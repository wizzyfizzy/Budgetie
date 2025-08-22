//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import XCTest
@testable import Auth
import AuthAPI
import DIModule

final class UserSessionRepoTests: XCTestCase {
    private func arrange() -> (repo: UserSessionRepo,
                               source: UserSessionSourceMock) {
        let source = UserSessionSourceMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(UserSessionSource.self) { _ in source }
        
        return (UserSessionRepoImpl(), source)
    }
    
    private let user = UserData(id: "42", email: "test@test.gr", fullName: "Kris")
    private let key = "currentUser"
    
    func testSaveUser() throws {
        // Arrange
        let arrange = arrange()
        arrange.source.stub.saveUser_Void = { _ in return () }
        
        // Act
        try arrange.repo.saveUser(user)
        
        // Assert
        XCTAssertEqual(arrange.source.verify.saveUser_Void.count, 1)
        XCTAssertEqual(arrange.source.verify.saveUser_Void.first, user)
        XCTAssertEqual(arrange.source.verify.saveUser_Void.first?.id, "42")
        XCTAssertEqual(arrange.source.verify.saveUser_Void.first?.email, "test@test.gr")
        XCTAssertEqual(arrange.source.verify.saveUser_Void.first?.fullName, "Kris")
    }
    
    func testGetUser() {
        // Arrange
        let arrange = arrange()
        arrange.source.stub.loadUser_UserData = { self.user }
        
        // Act
        let loadedUser = arrange.source.loadUser()
        
        // Assert
        XCTAssertEqual(arrange.source.verify.loadUser_UserData.count, 1)
        XCTAssertEqual(loadedUser, user)
        XCTAssertEqual(loadedUser?.id, "42")
        XCTAssertEqual(loadedUser?.email, "test@test.gr")
        XCTAssertEqual(loadedUser?.fullName, "Kris")
    }
    
    func testClearUser() {
        // Arrange
        let arrange = arrange()
        // Act
        arrange.repo.clearUser()
        
        // Assert
        XCTAssertEqual(arrange.source.verify.clear_Void.count, 1)
    }
}
