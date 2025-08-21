//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI

public class GetUserSessionUCImpl: GetUserSessionUC {
    @Injected private var repo: UserSessionRepo

    public init() {}

    public func execute() -> UserData? {
        repo.getUser()
    }
}
