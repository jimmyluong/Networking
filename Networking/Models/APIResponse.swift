
import Foundation

struct VoidResponse: Codable { }

struct APIResponse {
    
    let success: Bool
    let statusCode: Int?
    
    let requestURL: String
    let method: HttpMethod
    
    let data: Data?
    let error: Error?
    
    
    init(success: Bool, statusCode: Int?, requestURL: String, method: HttpMethod, data: Data?, error: Error?) {
        self.success = success
        self.statusCode = statusCode
        self.requestURL = requestURL
        self.method = method
        self.data = data
        self.error = error
    }
}


struct ErrorResponse: Codable {
    
    let statusCode: Int
    let error: String?
    let message: String?
}
