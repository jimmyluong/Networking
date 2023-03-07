
import Foundation

struct MedicalExaminationDetailResponse: Codable {
    
    let statusCode: Int
    let message: String?
    let data: MedicalExaminationDetailDataResponse?
}

struct MedicalExaminationDetailDataResponse: Codable {
    let id: Int
    let patient: Int?
    let updateBy: String?
    let createBy: String?
    let dateOfExamination: String?
    let disease, subjective, vital, objective, assessment, plan : String?
    let vitalBodyTemperature, vitalBloodPressureD, vitalBloodPressureS , vitalPulse, vitalSpO2: String?
    let objectiveConsciousness, objectiveBreathing, objectiveAbdomen, objectiveCirculation, objectiveGastrostomy: String?
    let updateAt: String?
    let createAt: String?
    let imageRes: [ExaminationImageResponse]?
}
