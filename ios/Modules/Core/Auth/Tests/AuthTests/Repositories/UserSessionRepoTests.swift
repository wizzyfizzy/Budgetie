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
    
    private let user = UserData(id: "42", email: "test@test.gr", name: "Kris", token: "123")
    
    func testSaveUser() throws {
        // Arrange
        let (repo, source) = arrange()
        source.stub.saveUser_Void = { _ in return () }
        
        // Act
        try repo.saveUser(user)
        
        // Assert
        XCTAssertEqual(source.verify.saveUser_Void.count, 1)
        XCTAssertEqual(source.verify.saveUser_Void.first, user)
        XCTAssertEqual(source.verify.saveUser_Void.first?.id, "42")
        XCTAssertEqual(source.verify.saveUser_Void.first?.email, "test@test.gr")
        XCTAssertEqual(source.verify.saveUser_Void.first?.name, "Kris")
    }
    
    func testGetUser() {
        // Arrange
        let (_, source) = arrange()
        source.stub.loadUser_UserData = { self.user }
        
        // Act
        let receivedUser = source.loadUser()
        
        // Assert
        XCTAssertEqual(source.verify.loadUser_UserData.count, 1)
        XCTAssertEqual(receivedUser, user)
        XCTAssertEqual(receivedUser?.id, "42")
        XCTAssertEqual(receivedUser?.email, "test@test.gr")
        XCTAssertEqual(receivedUser?.name, "Kris")
    }
    
    func testGetUserPublisher() throws {
        // Arrange
        let (repo, source) = arrange()
        source.stub.saveUser_Void = { _ in return () }
        source.stub.loadUser_UserData = { self.user }
        
        let expectation = XCTestExpectation(description: "Publisher emits user")
        
        var receivedUser: UserData?
        let cancellable = repo.getUserPublisher()
            .sink { user in
                receivedUser = user
                expectation.fulfill()
            }
        
        // Act
        try repo.saveUser(user)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedUser, user)
        XCTAssertEqual(source.verify.saveUser_Void.first, receivedUser)
        XCTAssertEqual(receivedUser?.id, "42")
        XCTAssertEqual(receivedUser?.email, "test@test.gr")
        XCTAssertEqual(receivedUser?.name, "Kris")
        cancellable.cancel()
    }
    
    func testClearUser() {
        // Arrange
        let (repo, source) = arrange()
        source.stub.loadUser_UserData = { nil }
        
        // Act
        repo.clearUser()
        let receivedUser = source.loadUser()
        
        // Assert
        XCTAssertEqual(source.verify.clear_Void.count, 1)
        XCTAssertNil(receivedUser)
    }
    
    func testClearUserUpdatesPublisher() {
        // Arrange
        let (repo, source) = arrange()
        source.stub.loadUser_UserData = { nil }
        let expectation = XCTestExpectation(description: "Publisher emits nil")
        
        var receivedUser: UserData? = self.user
        let cancellable = repo.getUserPublisher()
            .sink { user in
                receivedUser = user
                expectation.fulfill()
            }
     
        // Act
        repo.clearUser()

        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(receivedUser)
        cancellable.cancel()
    }
    
    func testGetUserPublisherStartsWithNilIfNoUser() {
        // Arrange
        let (repo, source) = arrange()
        source.stub.loadUser_UserData = { nil }
        
        let expectation = XCTestExpectation(description: "Publisher emits nil")
        var received: UserData??
        
        let cancellable = repo.getUserPublisher()
            .sink { user in
                received = user
                expectation.fulfill()
            }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(received ?? UserData?.none)
        cancellable.cancel()
    }
    
    func testMultipleSubscribersReceiveUpdates() throws {
        // Arrange
        let (repo, source) = arrange()
        source.stub.saveUser_Void = { _ in return () }
        source.stub.loadUser_UserData = { self.user }
        
        let exp1 = XCTestExpectation(description: "First subscriber")
        let exp2 = XCTestExpectation(description: "Second subscriber")
        
        var user1: UserData?
        var user2: UserData?
        
        let cancellable1 = repo.getUserPublisher()
            .sink {
                user1 = $0
                exp1.fulfill()
            }
        let cancellable2 = repo.getUserPublisher()
            .sink {
                user2 = $0
                exp2.fulfill()
            }
        
        // Act
        try repo.saveUser(user)
        
        // Assert
        wait(for: [exp1, exp2], timeout: 1.0)
        XCTAssertEqual(user1, user)
        XCTAssertEqual(user2, user)
        
        cancellable1.cancel()
        cancellable2.cancel()
    }
    
}
