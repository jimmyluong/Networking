

import Foundation

struct ApprovalExaminationRequest: Codable {
    let isApproval: Bool
    let message: String
}

struct ApprovalExaminationAgrument {
    let patientID: Int
    let examinationID: Int
    let isApproval: Bool
    let message: String
    let confirmationID: String
    let socketID: String
}
