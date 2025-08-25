//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import XCTest
@testable import Auth
import AuthAPI
import UIComponents

final class UserSessionSourceTests: XCTestCase {
    private func arrange() -> (source: UserSessionSource,
                               store: SecureStore,
                               userDefaults: UserDefaults) {
        
        let suiteName = "UserSessionSourceTests"
        let userDefaults = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
        userDefaults.removePersistentDomain(forName: suiteName)
        
        let store: SecureStore = KeychainSecureStoreMock()
        let source = UserSessionSourceImpl(store: store, userDefaults: userDefaults)
       
        return (source, store, userDefaults)
    }
    
    private let user = UserData(id: "123", email: "test@test.gr", name: "Kris", token: "123")
    private let key = "currentUser"

    func testLoadUserWithoutSaveReturnsNil() {
        // Arrange
        let (source, _, _) = arrange()

        // Act
        let receivedUser = source.loadUser()
        
        // Assert
        XCTAssertNil(receivedUser)
    }
    
    func testLoadUserKeychain() throws {
        // Arrange
        let (_, store, _) = arrange()

        // Act
        try store.save(user, key: key)
        let receivedUser = store.load(key, as: UserData.self)
        
        // Assert
        XCTAssertNotNil(receivedUser)
        XCTAssertEqual(receivedUser, user)
        XCTAssertEqual(receivedUser?.id, "123")
        XCTAssertEqual(receivedUser?.email, "test@test.gr")
        XCTAssertEqual(receivedUser?.name, "Kris")
    }
    
    func testSaveOverwritesPreviousUser() throws {
        // Arrange
        let (source, _, _) = arrange()
        let user1 = UserData(id: "1", email: "a@test.com", name: "A", token: "111")
        let user2 = UserData(id: "2", email: "b@test.com", name: "B", token: "222")

        // Act
        try source.save(user: user1)
        try source.save(user: user2)

        // Assert
        let loaded = source.loadUser()
        XCTAssertEqual(loaded, user2)
    }
    
    func testClearUserKeychain() throws {
        // Arrange
        let (source, store, _) = arrange()

        // Act
        try store.save(user, key: key)
        store.delete(key)
        let receivedUser = source.loadUser()
        
        // Assert
        XCTAssertNil(receivedUser)
    }
    
    func testClearWithoutSaveDoesNotCrash() {
        // Arrange
        let (source, _, _) = arrange()

        // Act
        source.clear()
        
        // Assert
        XCTAssertNil(source.loadUser())
    }

    func testSaveAndRetrieveUserSession() throws {
        // Arrange
        let (source, _, _) = arrange()

        try source.save(user: user)

        let receivedUser = source.loadUser()
        XCTAssertNotNil(receivedUser)
        XCTAssertEqual(receivedUser?.id, "123")
        XCTAssertEqual(receivedUser?.email, "test@test.gr")
        XCTAssertEqual(receivedUser?.name, "Kris")
    }
    
    func testClearUserKeSession() throws {
        // Arrange
        let (source, _, _) = arrange()

        // Act
        try source.save(user: user)
        source.clear()
        let receivedUser = source.loadUser()
        
        // Assert
        XCTAssertNil(receivedUser)
    }
    
    func testUserDefaultsFlagUpdatesCorrectly() throws {
        let (source, _, userDefaults) = arrange()

        try source.save(user: user)
        XCTAssertTrue(userDefaults.isUserLoggedIn)

        source.clear()
        XCTAssertFalse(userDefaults.isUserLoggedIn)
    }
}
