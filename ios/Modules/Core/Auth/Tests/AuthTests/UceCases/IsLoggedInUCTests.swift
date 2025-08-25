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
import Combine

final class IsLoggedInUCTests: XCTestCase {
    private func arrange() -> (isLoggedInUC: IsLoggedInUC,
                               repo: UserSessionRepoMock) {
        
        let repo = UserSessionRepoMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(UserSessionRepo.self) { _ in repo }
        
        return (IsLoggedInUCImpl(), repo)
    }
    private let user = UserData(id: "42", email: "test@test.gr", name: "Kris", token: "123")
    
    func testExecute_WithUser() {
        // Arrange
        let (useCase, repo) = arrange()
        repo.stub.getUser_UserData = { self.user }
        
        // Act
        let result = useCase.execute()
        
        // Assert
        XCTAssertTrue(result)
        XCTAssertEqual(repo.verify.getUser_UserData.count, 1)
    }
    
    func testExecute_NoUser() {
        // Arrange
        let (useCase, repo) = arrange()
        repo.stub.getUser_UserData = { nil }
        
        // Act
        let result = useCase.execute()
        
        // Assert
        XCTAssertFalse(result)
        XCTAssertEqual(repo.verify.getUser_UserData.count, 1)
    }
    
    func testExecutePublisher_WithUser() {
        // Arrange
        let (useCase, repo) = arrange()
        repo.stub.getUserPublisher_Pub_UserData_Never = {
            Just(self.user).eraseToAnyPublisher()
        }
        
        // Act
        let exp = expectation(description: "Publisher emits user")
        var result: Bool?
        
        let cancellable = useCase.executePublisher()
            .sink { value in
                result = value
                exp.fulfill()
            }
        
        // Assert
        wait(for: [exp], timeout: 1)
        XCTAssertTrue(result ?? false)
        XCTAssertEqual(repo.verify.getUserPublisher_Pub_UserData_Never.count, 1)
        cancellable.cancel()
    }
    
    func testExecutePublisher_NoUser() {
        // Arrange
        let (useCase, repo) = arrange()
        repo.stub.getUserPublisher_Pub_UserData_Never = {
            Just(nil).eraseToAnyPublisher()
        }

        // Act
        let exp = expectation(description: "Publisher emits false")
        var result: Bool?
        
        let cancellable = useCase.executePublisher()
            .sink { value in
                result = value
                exp.fulfill()
            }
        
        // Assert
        wait(for: [exp], timeout: 1)
        XCTAssertFalse(result ?? true)
        XCTAssertEqual(repo.verify.getUserPublisher_Pub_UserData_Never.count, 1)
        cancellable.cancel()
    }
}
