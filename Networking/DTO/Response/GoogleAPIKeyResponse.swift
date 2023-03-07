
import Foundation

struct GoogleAPIKeyResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: GoogleAPIKeyDataResponse?
}

// MARK: - DataClass
struct GoogleAPIKeyDataResponse: Codable {
    let googleSttKey: String
}
