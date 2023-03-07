

import Foundation

enum UserEndpoints {
    
    class TotalPatientWaitingConfirm: APIRequest<VoidRequest, TotalPatientWaitingConfirmResponse> {
    
        init() {
            super.init(resource: "api/v1/confirmations/count",
                      data: nil)
        }
    }
    
    class UserInfo: APIRequest<VoidRequest, CurrentUserInfoResponse> {
        init(userID: Int) {
            super.init(resource: "api/v1/user/info/\(userID)")
        }
    }
}
