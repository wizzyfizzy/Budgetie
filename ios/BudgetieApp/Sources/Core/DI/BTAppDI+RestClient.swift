//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import BTRestClientAPI
import BTRestClient

extension BTAppDI {
    func registerBTRestClient() {
        
        register(HTTPClient.self) { _ in GenericHTTPClient() }
    }
}
