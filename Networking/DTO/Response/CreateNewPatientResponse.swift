
import Foundation

struct CreateNewPatientResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: CreateNewPatientDataResponse?
}


struct CreateNewPatientDataResponse: Codable {
    let id: Int
}
