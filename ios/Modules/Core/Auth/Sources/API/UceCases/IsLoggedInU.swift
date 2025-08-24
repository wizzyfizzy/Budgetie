//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Combine

// sourcery: AutoMockable
/// Handles logging in a user.
public protocol IsLoggedInUC {
    func execute() -> Bool
    func executePublisher() -> AnyPublisher<Bool, Never>
}
