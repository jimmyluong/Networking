
import Foundation

struct PatientListRequest: Codable {
    let pageNumber, pageSize: Int
    let patientName: String
    let clinicID: Int?
    var patientStatus: String?
}
