
import Foundation
import Alamofire

class SomeRetryPolicy: RetryPolicy {
    
    private lazy var authenticationService: AuthenticationService? = AppDelegate.container.resolve(AuthenticationService.self)
    
    override func retry(_ request: Request,
                    for session: Alamofire.Session,
                    dueTo error: Error,
                    completion: @escaping (RetryResult) -> Void) {
        
        if request.retryCount < retryLimit, shouldRetry(request: request, dueTo: error) {
            completion(.retryWithDelay(pow(Double(exponentialBackoffBase), Double(request.retryCount)) * exponentialBackoffScale))
        } else {
            completion(.doNotRetry)
            
            /// Logout when status error == 401
            if error.asAFError?.responseCode == 401 {
                self.authenticationService?.removeSession()
            }
        }
    }
}
