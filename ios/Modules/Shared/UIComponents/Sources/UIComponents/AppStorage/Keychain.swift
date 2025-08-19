//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import Foundation
import Security
import Security

/// A lightweight wrapper around Apple's Keychain Services API.
/// Provides methods for saving, loading, and deleting secure data such as tokens or credentials.
public enum Keychain {
    
    /// Saves a value in the Keychain for the specified service and account.
    ///
    /// If an entry already exists, it will be deleted before saving the new value.
    ///
    /// - Parameters:
    ///   - service: A string that identifies your app's service, e.g. `"com.budgetie.auth"`.
    ///   - account: The account identifier, e.g. `"userToken"` or a username/email.
    ///   - data: The data to be securely stored in the Keychain.
    ///   - accessible: The accessibility level (default: `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`).
    /// - Throws: `KeychainError` if saving fails.
    public static func save(
        service: String,
        account: String,
        data: Data,
        accessible: CFString = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
    ) throws {
        // Delete existing item before saving a new one
        try? delete(service: service, account: account)

        var query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: data,
            kSecAttrAccessible: accessible
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError(status: status)
        }
    }

    /// Loads a previously saved value from the Keychain.
    ///
    /// - Parameters:
    ///   - service: The service string used when saving the value.
    ///   - account: The account identifier used when saving the value.
    /// - Returns: The stored `Data` if found.
    /// - Throws: `KeychainError` if the item is not found or another error occurs.
    public static func load(service: String, account: String) throws -> Data {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data else {
            throw KeychainError(status: status)
        }
        return data
    }

    /// Deletes a value from the Keychain.
    ///
    /// - Parameters:
    ///   - service: The service string used when saving the value.
    ///   - account: The account identifier used when saving the value.
    /// - Throws: `KeychainError` if deletion fails.
    ///   Does **not** throw if the item was not found.
    public static func delete(service: String, account: String) throws {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError(status: status)
        }
    }

    /// A wrapper around Keychain OSStatus errors, providing human-readable messages.
    public struct KeychainError: Error, LocalizedError {
        /// The raw `OSStatus` code returned by Keychain Services.
        let status: OSStatus
        
        /// A human-readable description of the Keychain error.
        public var errorDescription: String? {
            (SecCopyErrorMessageString(status, nil) as String?) ?? "Keychain error \(status)"
        }
    }
}
