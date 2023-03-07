

import Foundation
import Alamofire

class SomeRestClient: BaseRestClient {
    
    init() {
        let interceptor = Interceptor(adapters: [SomeAccessTokenAdapter()], retriers: [SomeRetryPolicy()])
        
        super.init(with: Environment.apiURL, interceptor: interceptor)
    }
}
