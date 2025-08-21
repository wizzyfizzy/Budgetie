//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import Foundation
import Security

/// Keys used for storing/retrieving data in the Keychain.
/// Centralized for easy reuse across the app.
public enum KeychainKeys {
    /// Key for storing the currently logged-in user data.
    public static let loggedInUser = "loggedInUser"
}

/// A utility class to perform common Keychain operations.
/// Supports saving, loading, and deleting `Codable` objects.
public final class KeychainManager {

    /// Saves a `Codable` object securely in the Keychain under the given key.
    ///
    /// - Parameters:
    ///   - object: The `Codable` object to store.
    ///   - key: The unique key under which the object will be saved.
    /// - Throws: An `NSError` if the Keychain operation fails.
    public static func save<T: Codable>(_ object: T, key: String) throws {
        let data = try JSONEncoder().encode(object)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // Delete any existing item before saving new one
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw NSError(domain: "KeychainError", code: Int(status), userInfo: nil)
        }
    }
    
    /// Loads and decodes a `Codable` object from the Keychain for the given key.
    ///
    /// - Parameters:
    ///   - key: The key associated with the stored object.
    ///   - type: The type of the object to decode.
    /// - Returns: The decoded object if found and successfully decoded, otherwise `nil`.
    public static func load<T: Codable>(_ key: String, as type: T.Type) -> T? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    /// Deletes the object stored in the Keychain for the given key.
    ///
    /// - Parameter key: The key associated with the object to delete.
    public static func delete(_ key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
