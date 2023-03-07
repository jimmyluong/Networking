
import Foundation

struct MedicalExaminationConfirmStatesResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: ExaminationConfirmStatesDataResponse?
}

// MARK: - Data
struct ExaminationConfirmStatesDataResponse: Codable {
    let state: String
}
