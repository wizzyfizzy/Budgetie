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
                                 store: SecureStore) {
        let store: SecureStore = KeychainSecureStoreMock()
        let source = UserSessionSourceImpl(store: store)
        return (source, store)
    }
    
    private let user = UserData(id: "123", email: "test@test.gr", fullName: "Kris")
    private let key = "currentUser"

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
        XCTAssertEqual(loadedUser?.fullName, "Kris")
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
    
    func testSaveAndRetrieveUserSession() throws {
        // Arrange
        let arrange = arrange()
        
        try arrange.source.save(user: user)

        let loadedUser = arrange.source.loadUser()
        XCTAssertNotNil(loadedUser)
        XCTAssertEqual(loadedUser?.id, "123")
        XCTAssertEqual(loadedUser?.email, "test@test.gr")
        XCTAssertEqual(loadedUser?.fullName, "Kris")
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
    

}
