
import Foundation

struct PatientListResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: PatientListDataResponse?
}

struct PatientListDataResponse: Codable {
    let total, currentPage, pageSizeLimit: Int
    let results: [PatientResponse]?
}

struct PatientResponse: Codable {
    let id: Int
    let externalID: Int?
    let name, nameKana, birthday, sex: String?
    let examinationID: Int?
    let dateOfExamination: String?
    let confirmationID: String?
}
