

import Foundation

struct ListRecordRequest: Codable {
    let patientID: Int
    let pageNumber, pageSize: Int
}

struct ListRecordArgument {
    let patientID: Int
    let pageNumber, pageSize: Int
}
