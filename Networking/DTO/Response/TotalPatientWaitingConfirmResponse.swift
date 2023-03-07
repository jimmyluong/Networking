

import Foundation

struct TotalPatientWaitingConfirmResponse: Codable {
    let statusCode: Int
    let message: String?
    var data: TotalWaitingConfirmDataResponse?
}

struct TotalWaitingConfirmDataResponse: Codable {
    let numOfConfirmation: Int
}
