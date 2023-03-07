
import Foundation

struct EditMedicalExaminationResponse: Codable {
    
    let statusCode: Int
    let message: String?
    let data: EditMedicalExaminationData?
}

// MARK: Data
struct EditMedicalExaminationData: Codable {
    let id: String
}
