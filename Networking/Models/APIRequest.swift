
import Foundation
import Alamofire

struct VoidRequest: Encodable { }

class APIRequest<TRequest: Encodable, TResponse: Codable> {
    
    let method: HttpMethod
    let resource: String
    let expectedCode: Int
    let data: TRequest?
    let headers: HTTPHeaders?
    let queryItems: [URLQueryItem]?
    
    init(resource: String,
         method: HttpMethod = .get,
         expectedCode: Int = 200,
         data: TRequest? = nil,
         headers: HTTPHeaders = [],
         queryItems: [URLQueryItem] = []) {
        
        self.resource = resource
        self.method = method
        self.expectedCode = expectedCode
        self.data = data
        self.headers = headers
        self.queryItems = queryItems
    }
}

class UploadRequest<TRequest: Encodable, TResponse: Codable> {
    
    let method: HttpMethod
    let resource: String
    let expectedCode: Int
    let data: TRequest?
    let dataFile: Data?
    let mimeType: String?
    let fileName: String?
    let headers: HTTPHeaders?
    
    init(resource: String,
        method: HttpMethod = .post,
        expectedCode: Int = 200,
        data: TRequest? = nil,
        dataFile: Data? = nil,
        mimeType: String? = nil,
        fileName: String? = nil,
        headers: HTTPHeaders = []) {
        
        self.resource = resource
        self.method = method
        self.expectedCode = expectedCode
        self.data = data
        self.dataFile = dataFile
        self.mimeType = mimeType
        self.fileName = fileName
        self.headers = headers
    }
}

// MARK:
extension URL {
    
    func addQuery(_ queryItem: String, value: String?) -> URL {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        
        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)
        
        // Append the new query item in the existing query items array
        queryItems.append(queryItem)
        
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        
        // Returns the url from new url components
        return urlComponents.url!
    }
}
