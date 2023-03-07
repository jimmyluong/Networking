

import Foundation

struct PatientRecordResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: RecordDataResponse?
}

struct RecordDataResponse: Codable {
    let total, currentPage, pageSizeLimit: Int
    let results: [RecordResponse]?
}

struct RecordResponse: Codable {
    let id: Int
    let patientID: Int?
    let dateOfExamination: String?
    let sendStatus: String?
    let webConfirmStatus: String?
    let confirmationID: String?
}
