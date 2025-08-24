//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Combine

// sourcery: AutoMockable
/// Retrieves the current user session.
public protocol GetUserSessionUC {
    /// Returns the current user data, if any.
    func execute() -> UserData?
    /// Returns a publisher that emits the current user data whenever it changes.
    func executePublisher() -> AnyPublisher<UserData?, Never>
}
