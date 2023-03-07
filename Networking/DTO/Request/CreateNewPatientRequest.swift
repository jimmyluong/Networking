
import Foundation

struct CreateNewPatientRequest: Codable {
    let clinicID: Int?
    let name: String
    let nameKana: String?
    let birthday: String?
    let sex: String?
    let externalID: Int?
    let visit: String?
    let visitAddress: String?
}

// MARK: Param of service
struct CreateNewPatientArgument {
    let clinicID: Int?
    let name: String
    let kanaName: String?
    let dateOfBirth: String?
    let sex: String?
    let externalID: Int?
    let visit: String?
    let visitAddress: String?
}
