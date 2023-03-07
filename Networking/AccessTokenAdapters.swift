
import Foundation
import Alamofire

class SomeAccessTokenAdapter: RequestAdapter {

    private lazy var authenticationService: AuthenticationService? = AppDelegate.container.resolve(AuthenticationService.self)
    
    func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        if let token = self.authenticationService?.token {
            urlRequest.headers.add(.authorization(token.AuthorizationHeader))
        }
        
        completion(.success(urlRequest))
    }
}
