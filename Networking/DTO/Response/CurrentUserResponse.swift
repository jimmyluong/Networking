
import Foundation

struct CurrentUserResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: CurrentUserData?
}

// MARK: - DataClass
struct CurrentUserData: Codable {
    let id: Int
    let role: String
    let homisID: Int
}
