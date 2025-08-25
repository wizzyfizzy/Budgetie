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
        let arrange = arrange()
        
        // Act
        let loadedUser = arrange.source.loadUser()
        
        // Assert
        XCTAssertNil(loadedUser)
    }
    
    func testLoadUserKeychain() throws {
        // Arrange
        let arrange = arrange()
        
        // Act
        try arrange.store.save(user, key: key)
        let loadedUser = arrange.store.load(key, as: UserData.self)
        
        // Assert
        XCTAssertNotNil(loadedUser)
        XCTAssertEqual(loadedUser, user)
        XCTAssertEqual(loadedUser?.id, "123")
        XCTAssertEqual(loadedUser?.email, "test@test.gr")
        XCTAssertEqual(loadedUser?.name, "Kris")
    }
    
    func testSaveOverwritesPreviousUser() throws {
        // Arrange
        let arrange = arrange()
        let user1 = UserData(id: "1", email: "a@test.com", name: "A", token: "111")
        let user2 = UserData(id: "2", email: "b@test.com", name: "B", token: "222")

        // Act
        try arrange.source.save(user: user1)
        try arrange.source.save(user: user2)

        // Assert
        let loaded = arrange.source.loadUser()
        XCTAssertEqual(loaded, user2)
    }
    
    func testClearUserKeychain() throws {
        // Arrange
        let arrange = arrange()
        
        // Act
        try arrange.store.save(user, key: key)
        arrange.store.delete(key)
        let loadedUser = arrange.source.loadUser()
        
        // Assert
        XCTAssertNil(loadedUser)
    }
    
    func testClearWithoutSaveDoesNotCrash() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.source.clear()
        
        // Assert
        XCTAssertNil(arrange.source.loadUser())
    }

    func testSaveAndRetrieveUserSession() throws {
        // Arrange
        let arrange = arrange()
        
        try arrange.source.save(user: user)

        let loadedUser = arrange.source.loadUser()
        XCTAssertNotNil(loadedUser)
        XCTAssertEqual(loadedUser?.id, "123")
        XCTAssertEqual(loadedUser?.email, "test@test.gr")
        XCTAssertEqual(loadedUser?.name, "Kris")
    }
    
    func testClearUserKeSession() throws {
        // Arrange
        let arrange = arrange()
        
        // Act
        try arrange.source.save(user: user)
        arrange.source.clear()
        let loadedUser = arrange.source.loadUser()
        
        // Assert
        XCTAssertNil(loadedUser)
    }
    
    func testUserDefaultsFlagUpdatesCorrectly() throws {
        let arrange = arrange()

        try arrange.source.save(user: user)
        XCTAssertTrue(arrange.userDefaults.isUserLoggedIn)

        arrange.source.clear()
        XCTAssertFalse(arrange.userDefaults.isUserLoggedIn)
    }
}
