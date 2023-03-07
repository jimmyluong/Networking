

import Foundation

struct StopMedicalExaminationRequest: Codable {
    let patientID: Int
    let examinationID: Int
    let editSectionID: String
}
