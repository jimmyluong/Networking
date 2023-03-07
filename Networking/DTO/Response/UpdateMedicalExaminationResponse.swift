
import Foundation

struct UpdateMedicalExaminationResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: UpdateMedicalExaminationDataResponse?
}

// MARK: - Data
struct UpdateMedicalExaminationDataResponse: Codable {
    let id: Int
}
