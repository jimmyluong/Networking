

import Foundation

struct RefreshTokenRequest: Codable {
    let refreshToken: String
    let grantType: String
    let clientId: String
    
    enum CodingKeys: String, CodingKey {
      case refreshToken = "refresh_token"
      case grantType = "grant_type"
      case clientId = "user_id"
    }
}
