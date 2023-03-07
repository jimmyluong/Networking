
import Foundation
import RxSwift
import Alamofire


struct OAuthCredential: AuthenticationCredential {
    
    let accessToken: String
    let expiration: Date
    
    var requiresRefresh: Bool {
        return Date(timeIntervalSinceNow: 30) > expiration
    }
}

class OAuthAuthenticator: Authenticator {

    private var disposeBag = DisposeBag()
    
    private lazy var authenticationService: AuthenticationService? = AppDelegate.container.resolve(AuthenticationService.self)
    
    
    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        
        if let localToken = self.authenticationService?.token, localToken.token != credential.accessToken {
            urlRequest.headers.add(.authorization(bearerToken: localToken.token))
        } else {
            urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
        }
    }
    
    func refresh(_ credential: OAuthCredential,
                 for session: Alamofire.Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
        
        if let localToken = self.authenticationService?.token, localToken.token != credential.accessToken {
            let creds = OAuthCredential(accessToken: localToken.token, expiration: localToken.expirationDate)
            completion(.success(creds))
        } else {
            self.authenticationService?.removeSession()
            completion(.failure(APIError.methodNotSupported))
        }
    }
    
    
    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
        
        return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        // If authentication server CANNOT invalidate credentials, return `true`
        return true

        // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
        // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
        // let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        // return urlRequest.headers["Authorization"] == bearerToken
    }
    
}
