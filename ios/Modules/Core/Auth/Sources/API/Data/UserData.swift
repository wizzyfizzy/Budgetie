//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

public struct UserData: Codable, Equatable {
    public let id: String
    public let email: String?
    public let fullName: String?
    
    public init(id: String, email: String?, fullName: String?) {
        self.id = id
        self.email = email
        self.fullName = fullName
    }
}
