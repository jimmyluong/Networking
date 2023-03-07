

import Foundation

struct PatientExaminationPreviewResponse: Codable {
    
    let statusCode: Int
    let message: String?
    let data: ExaminationPreviewResponse?
    
}

struct ExaminationPreviewResponse: Codable {
    let id: Int
    let patient: Int?
    let updateBy: String?
    let createBy: String?
    let createAt: String?
    let dateOfExamination: String?
    let disease, subjective, vital, objective, assessment, plan : String?
    let vitalBodyTemperature, vitalBloodPressureD, vitalBloodPressureS , vitalPulse, vitalSpO2: String?
    let objectiveConsciousness, objectiveBreathing, objectiveAbdomen, objectiveCirculation, objectiveGastrostomy: String?
    let updateAt: String?
    let imageRes: [ExaminationImageResponse]?
    let confirmation: String?
}

struct UpdateByResponse: Codable {
    let id: Int?
    let fullName: String?
}

struct ExaminationImageResponse: Codable {
    let categoryName, fileName, link, uploadAt: String?
}
