

import Foundation

struct UploadFileResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: UploadFileDataResponse?
}

struct UploadFileDataResponse: Codable {
    let categoryName: String?
    let fileName: String?
    let link: String?
    let createAt: String?
}
