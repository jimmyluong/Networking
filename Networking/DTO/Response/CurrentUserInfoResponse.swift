
import Foundation

struct CurrentUserInfoResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: UserInfoData?
}

// MARK: - DataClass
struct UserInfoData: Codable {
    let id: Int
    let fullName: String
}
