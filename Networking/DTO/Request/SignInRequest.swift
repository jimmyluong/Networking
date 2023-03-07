
import Foundation

struct SignInRequest: Codable {
    let username: String
    let password: String
    let via: String
    let lang: String
}
