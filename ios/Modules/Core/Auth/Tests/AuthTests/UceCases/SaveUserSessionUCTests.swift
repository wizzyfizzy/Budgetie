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
        let arrange = arrange()
        let user = UserData(id: "42", email: "test@test.gr", fullName: "Kris")
        arrange.repo.stub.saveUser_Void = { _ in return () }

        // Act
        try arrange.saveUserUC.execute(user: user)
        
        // Assert
        XCTAssertEqual(arrange.repo.verify.saveUser_Void.count, 1)
        XCTAssertEqual(arrange.repo.verify.saveUser_Void.first, user)
        XCTAssertEqual(arrange.repo.verify.saveUser_Void.first?.id, user.id)
        XCTAssertEqual(arrange.repo.verify.saveUser_Void.first?.email, user.email)
        XCTAssertEqual(arrange.repo.verify.saveUser_Void.first?.fullName, user.fullName)
//        XCTAssertEqual(AppState.shared.userID, user.id)
    }
    
    func testExecute_throwError() throws {
        // Arrange
        let arrange = arrange()
        let user = UserData(id: "42", email: "test@test.gr", fullName: "Kris")
        arrange.repo.stub.saveUser_Void = { _ in throw NSError(domain: "Test", code: 1) }

        // Act + Assert
        XCTAssertThrowsError(try arrange.saveUserUC.execute(user: user))
    }
}
