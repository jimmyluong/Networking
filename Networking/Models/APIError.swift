
import Foundation

public enum APIError: Error {
    
    case requestFailed(statusCode: Int?, response: Data?)
    
    case methodNotSupported
    
    case networkError(error: Error?)
    
    
    var errorResponse: ErrorResponse? {
        switch self {
        case .requestFailed( _ , let response):
            let jsonDecoder = JSONDecoder()
            guard let response = response,
                  let error = try? jsonDecoder.decode(ErrorResponse.self, from: response) else {
                return nil
            }
            
            // FiXME: check  statusCode == 429, then error localized message follow client
//            if error.statusCode == 429 {
//                return ErrorResponse(statusCode: error.statusCode, error: nil, message: "common_error_429".localized)
//            }
            
            return error
        case .methodNotSupported:
            return nil
        case .networkError(let error):
            guard let castError = error else { return nil }
            
            let statusCode: Int = (castError as NSError).code
            
            return ErrorResponse(statusCode: statusCode, error: nil, message: castError.localizedDescription)
        }
    }
}

extension Error {

    public var asAPIError: APIError? {
        return self as? APIError
    }
}


extension Error {
    
    var errorCode: Int {
        return (self as NSError).code
    }
    
    var urlCode: URLError.Code? {
        return (self as? URLError)?.code
    }
    
    var isTimeout: Bool {
        return urlCode == .timedOut
    }
    
    var isHostNotFound: Bool {
        return urlCode == .cannotFindHost
    }
    
    var isHostConnectFailed: Bool {
        return urlCode == .cannotConnectToHost
    }
    
    var isNetworkConnectionLost: Bool {
        return urlCode == .networkConnectionLost
    }
    
    var isInternetOffline: Bool {
        return urlCode == .notConnectedToInternet
    }
    
    var isBadServerResponse: Bool {
        return urlCode == .badServerResponse
    }
}
