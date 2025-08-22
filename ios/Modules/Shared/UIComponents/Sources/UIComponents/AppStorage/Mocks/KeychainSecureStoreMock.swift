//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

public final class KeychainSecureStoreMock: SecureStore {
    private var storage: [String: Data] = [:]
    
    public init() {}
    
    public func save<T: Codable>(_ object: T, key: String) throws {
        storage[key] = try JSONEncoder().encode(object)
    }
    
    public func load<T: Codable>(_ key: String, as type: T.Type) -> T? {
        guard let data = storage[key] else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    public func delete(_ key: String) {
        storage.removeValue(forKey: key)
    }
}
