

import Foundation

struct ApprovalExaminationResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: ApprovalExaminationDataResponse?
    
}

struct ApprovalExaminationDataResponse: Codable{
    let patientID, examinationID: Int?
}

