

import Foundation
import Alamofire

enum AuthenticationEndpoints {
    
    class SignIn: APIRequest<SignInRequest, SignInResponse> {
        init(credentials: Credentials) {
            super.init(resource: "api/v1/auth",
                       method: .post,
                       expectedCode: 201,
                       data: SignInRequest(username: credentials.username, password: credentials.password, via: credentials.via, lang: credentials.lang),
                       headers: ["X-App-Language": credentials.lang])
        }
    }
    
    
    class RefreshToken: APIRequest<RefreshTokenRequest, SignInResponse> {
        init(token: RefreshTokenCredentials) {
            super.init(resource: "auth/access_token",
                       data: RefreshTokenRequest(refreshToken: token.refreshToken, grantType: token.grantType, clientId: token.clientId))
        }
    }

    
    class SignOut: APIRequest<VoidRequest, VoidResponse> {
        init() {
            super.init(resource: "api/v1/auth")
        }
    }
    
    
    class CurrentUser: APIRequest<VoidRequest, CurrentUserResponse> {
        init() {
            super.init(resource: "api/v1/user/current-user")
        }
    }
}


class AuthenticationTest {
    
    class LuongTiem: APIRequest<SignInRequest, SignInResponse> {
        init(credentials: Credentials) {
            super.init(resource: "api/v1/auth",
                       method: .post,
                       expectedCode: 201,
                       data: SignInRequest(username: credentials.username, password: credentials.password, via: credentials.via, lang: credentials.lang),
                       headers: ["X-App-Language": credentials.lang])
        }
    }
}
