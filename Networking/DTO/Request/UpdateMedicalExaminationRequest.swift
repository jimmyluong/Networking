
import Foundation

struct UpdateMedicalExaminationRequest: Codable {
    
    let dateOfExamination: String
    let examinedBy: Int
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
