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

final class GetUserSessionUCTests: XCTestCase {
    private func arrange() -> (getUserUC: GetUserSessionUC,
                               repo: UserSessionRepoMock) {
        
        let repo = UserSessionRepoMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(UserSessionRepo.self) { _ in repo }
        
        return (GetUserSessionUCImpl(), repo)
    }
    
    func testExecute() {
        // Arrange
        let arrange = arrange()
        let user = UserData(id: "42", email: "test@test.gr", fullName: "Kris")
        arrange.repo.stub.getUser_UserData = { user }
        
        // Act
        let loadedUser = arrange.getUserUC.execute()
        
        // Assert
        XCTAssertEqual(arrange.repo.verify.getUser_UserData.count, 1)
        XCTAssertEqual(loadedUser, user)
        XCTAssertEqual(loadedUser?.id, user.id)
        XCTAssertEqual(loadedUser?.email, user.email)
        XCTAssertEqual(loadedUser?.fullName, user.fullName)
    }
}
