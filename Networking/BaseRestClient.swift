
import Foundation
import RxSwift
import Alamofire

class BaseRestClient {
    
    private var session: Alamofire.Session
    private var headers: HTTPHeaders = []
    private let baseURL: String
    
    
    init(with baseURL: String, interceptor: RequestInterceptor? = nil) {
        
        if let interceptor = interceptor {
            self.session = Alamofire.Session(interceptor: interceptor)
        } else {
            self.session = Alamofire.Session.default
        }
        
        self.headers.add(.contentType("application/json"))
        self.headers.add(name: "X-App-Id", value: Environment.apiKeyHeader)
        self.baseURL = baseURL
    }
    
    
    func request<Y: Encodable, T:Codable>(_ request: APIRequest<Y, T>) -> Single<T>{

        return Single.create { single in
            
            let urlString = "\(self.baseURL)/\(request.resource)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            var url = URL(string: urlString)!
            
            if let queryItems = request.queryItems {
                for query in queryItems {
                    url = url.addQuery(query.name, value: query.value)
                }
            }
            
            var afRequest: DataRequest
            
            var headers = HTTPHeaders(self.headers.dictionary)
            
            if let requestHeaders = request.headers {
                for header in requestHeaders {
                    headers.add(header)
                }
            }
            
            switch request.method {
            case .get:
                afRequest = self.session.request(url, method: .get, parameters: request.data, encoder: URLEncodedFormParameterEncoder.default, headers: headers)
            case .post:
                afRequest = self.session.request(url, method: .post, parameters: request.data, encoder: JSONParameterEncoder.default, headers: headers)
            case .put:
                afRequest = self.session.request(url, method: .put, parameters: request.data, encoder: JSONParameterEncoder.default, headers: headers)
            case .delete:
                afRequest = self.session.request(url, method: .delete, parameters: request.data, encoder: JSONParameterEncoder.prettyPrinted, headers: headers)
            case .patch:
                afRequest = self.session.request(url, method: .patch, parameters: request.data, encoder: JSONParameterEncoder.default, headers: headers)
            default:
                Logger.error("No valid method was presented")
                single(.failure(APIError.methodNotSupported))
                return Disposables.create()
            }
            
            afRequest.response { response in
                Logger.debug(response.debugDescription)
            }
            .validate()
            .validate(statusCode: [request.expectedCode])
            .responseData { result in
                let response = APIResponse(success: result.error == nil, statusCode: result.response?.statusCode, requestURL: (result.request?.url?.absoluteString)!, method: .get, data: result.data, error: result.error)
                
                guard response.success else {
                    Logger.error("Unsuccessful request", error: response.error)
                    
                    if let requestFailed = response.data {
                        let error = APIError.requestFailed(statusCode: response.statusCode, response: requestFailed)
                        single(.failure(error))
                        return
                    }
                    
                    /// Handle casting  error when not connected internet
                    if let error = response.error?.asAFError?.underlyingError,
                        error.isTimeout || error.isInternetOffline || error.isNetworkConnectionLost || error.isHostConnectFailed {
                        
                        let error = APIError.networkError(error: response.error)
                        single(.failure(error))
                        return
                    }
                    
                    return
                }
                
                guard let parsedResponse = response.data?.toObject(T.self) else {
                    Logger.error("Could not parse response")
                    let error = APIError.requestFailed(statusCode: response.statusCode, response: response.data)
                    single(.failure(error))
                    return
                }
                
                single(.success(parsedResponse))
            }
            
            return Disposables.create {
                afRequest.cancel()
            }
        }
    }
    
}

// MARK: Handle cancel all request
extension BaseRestClient {
    
    func cancelAllRequest(completed: @escaping (() -> Void)) {
        self.session.cancelAllRequests(completingOnQueue: .main) {
            Logger.debug("Cancel all request done!")
            completed()
        }
    }
    
}


// MARK: Upload resource
extension BaseRestClient {
    
    func upload<Y: Encodable, T:Codable>(_ request: UploadRequest<Y, T>) -> Single<T>{
        return Single.create { single in
            let urlString = "\(self.baseURL)/\(request.resource)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: urlString)!
            
            var headers = HTTPHeaders(self.headers.dictionary)
            if let requestHeaders = request.headers {
                for header in requestHeaders {
                    headers.add(header)
                }
            }
            
            let afRequest: DataRequest = self.session.upload(multipartFormData: { multipartFormData in
                if let data = request.data, let parameters: [String: Any] = data.dictionary {
                    for (key, value) in parameters {
                        if let temp = value as? String {
                            multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                        }
                        if let temp = value as? Int {
                            multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                        }
                        if let temp = value as? NSArray {
                            temp.forEach({ element in
                                let keyObj = key + "[]"
                                if let string = element as? String {
                                    multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                                } else
                                if let num = element as? Int {
                                    let value = "\(num)"
                                    multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                                }
                            })
                        }
                    }
                }
                if let data = request.dataFile {
                    multipartFormData.append(data,
                                             withName: "file" ,
                                             fileName: request.fileName,
                                             mimeType: request.mimeType)
                }
                
            }, to: url, headers: headers)
            
            afRequest.response { response in
                Logger.debug(response.debugDescription)
            }
            .validate()
            .validate(statusCode: [request.expectedCode])
            .responseData { result in
                let response = APIResponse(success: result.error == nil, statusCode: result.response?.statusCode, requestURL: (result.request?.url?.absoluteString)!, method: .get, data: result.data, error: result.error)
                
                guard response.success else {
                    Logger.error("Unsuccessful request", error: response.error)
                    
                    if let requestFailed = response.data {
                        let error = APIError.requestFailed(statusCode: response.statusCode, response: requestFailed)
                        single(.failure(error))
                        return
                    }
                    
                    let error = APIError.networkError(error: response.error)
                    single(.failure(error))
                    return
                }
                
                guard let parsedResponse = response.data?.toObject(T.self) else {
                    Logger.error("Could not parse response")
                    let error = APIError.requestFailed(statusCode: response.statusCode, response: response.data)
                    single(.failure(error))
                    return
                }
                
                single(.success(parsedResponse))
            }
            
            return Disposables.create {
                afRequest.cancel()
            }
        }
    }
}
