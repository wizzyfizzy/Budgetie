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
import UIComponents

final class SaveUserSessionUCTests: XCTestCase {
    private func arrange() -> (saveUserUC: SaveUserSessionUC,
                               repo: UserSessionRepoMock) {
        
        let repo = UserSessionRepoMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(UserSessionRepo.self) { _ in repo }
        
        return (SaveUserSessionUCImpl(), repo)
    }
    
    func testExecute() throws {
        // Arrange
        let (useCase, repo) = arrange()
        let user = UserData(id: "42", email: "test@test.gr", name: "Kris", token: "123")
        repo.stub.saveUser_Void = { _ in return () }

        // Act
        try useCase.execute(user: user)
        
        // Assert
        XCTAssertEqual(repo.verify.saveUser_Void.count, 1)
        XCTAssertEqual(repo.verify.saveUser_Void.first, user)
        XCTAssertEqual(repo.verify.saveUser_Void.first?.id, user.id)
        XCTAssertEqual(repo.verify.saveUser_Void.first?.email, user.email)
        XCTAssertEqual(repo.verify.saveUser_Void.first?.name, user.name)
    }
    
    func testExecute_Error() throws {
        // Arrange
        let (useCase, repo) = arrange()
        let user = UserData(id: "42", email: "test@test.gr", name: "Kris", token: "123")
        repo.stub.saveUser_Void = { _ in throw NSError(domain: "Test", code: 1) }

        // Act + Assert
        XCTAssertThrowsError(try useCase.execute(user: user))
    }
    
    func testExecute_MultipleCalls() throws {
        let (useCase, repo) = arrange()
        let user1 = UserData(id: "1", email: "a@test.gr", name: "A", token: "tok1")
        let user2 = UserData(id: "2", email: "b@test.gr", name: "B", token: "tok2")
        repo.stub.saveUser_Void = { _ in }
        
        try useCase.execute(user: user1)
        try useCase.execute(user: user2)
        
        XCTAssertEqual(repo.verify.saveUser_Void.count, 2)
        XCTAssertEqual(repo.verify.saveUser_Void[0], user1)
        XCTAssertEqual(repo.verify.saveUser_Void[1], user2)
    }

}
