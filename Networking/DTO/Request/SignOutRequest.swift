

import Foundation

struct SignOutRequest: Codable {
    let refreshToken: String
    let fromAll: Bool?
    
    enum CodingKeys: String, CodingKey {
      case refreshToken = "refresh_token"
      case fromAll = "from_all"
    }
}
