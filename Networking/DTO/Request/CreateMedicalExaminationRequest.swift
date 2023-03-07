
import Foundation

struct CreateMedicalExaminationRequest: Codable {
    let dateOfExamination: String
    let disease, subjective, vital, objective: String
    let assessment, plan: String
    let resources: [CreateExaminationResourceRequest]
    
    let vitalBodyTemperature: String
    let vitalBloodPressureD: String
    let vitalBloodPressureS: String
    let vitalPulse: String
    let vitalSpO2: String
    
    let objectiveConsciousness: String
    let objectiveBreathing: String
    let objectiveAbdomen: String
    let objectiveCirculation: String
    let objectiveGastrostomy: String
}

// MARK: - Resource
struct CreateExaminationResourceRequest: Codable {
    let categoryName, fileName: String
    var link: String?
    var createAt: String?

    init(categoryName: String, fileName: String, link: String?, createAt: String?) {
        self.categoryName = categoryName
        self.fileName = fileName
        self.link = link
        self.createAt = createAt
    }
}
