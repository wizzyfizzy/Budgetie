//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import AuthAPI
import Combine

public final class IsLoggedInUCImpl: IsLoggedInUC {
    @Injected private var repo: UserSessionRepo

    public init() {}
    
    public func execute() -> Bool {
        repo.getUser() != nil
    }
    
    public func executePublisher() -> AnyPublisher<Bool, Never> {
        repo.getUserPublisher()
            .map { $0 != nil }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
