
import Foundation

struct ClinicListResponse: Codable {
    let statusCode: Int
    let message: String
    let data: [ClinicResponse]?
    
}

struct ClinicResponse: Codable {
    let id: Int
    let externalID: Int
    let name: String
    let abbreviationName: String
}
