
import Foundation

struct CreateMedicalExaminationResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: CreateMedicalExaminationDataResponse?
}

// MARK: - DataClass
struct CreateMedicalExaminationDataResponse: Codable {
    let id: Int
}
