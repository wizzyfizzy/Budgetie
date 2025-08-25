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

final class ClearUserSessionUCTests: XCTestCase {
    private func arrange() -> (clearUC: ClearUserSessionUC,
                               repo: UserSessionRepoMock) {
        let repo = UserSessionRepoMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(UserSessionRepo.self) { _ in repo }
        
        return (ClearUserSessionUCImpl(), repo)
    }
        
    func testExecute() {
        // Arrange
        let (useCase, repo) = arrange()

        // Act
        useCase.execute()
        
        // Assert
        XCTAssertEqual(repo.verify.clearUser_Void.count, 1)
    }
    
    func testExecute_MultipleCalls() {
        // Arrange
        let (useCase, repo) = arrange()

        // Act
        useCase.execute()
        useCase.execute()
        
        // Assert
        XCTAssertEqual(repo.verify.clearUser_Void.count, 2)
    }
    
    func testExecute_NoCallBeforeExecute() {
        // Arrange
        let (_, repo) = arrange()

        // Assert
        XCTAssertTrue(repo.verify.clearUser_Void.isEmpty)
    }


}
