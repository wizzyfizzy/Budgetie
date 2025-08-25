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
        let arrange = arrange()
        arrange.source.stub.saveUser_Void = { _ in return () }
        
        // Act
        try arrange.repo.saveUser(user)
        
        // Assert
        XCTAssertEqual(arrange.source.verify.saveUser_Void.count, 1)
        XCTAssertEqual(arrange.source.verify.saveUser_Void.first, user)
        XCTAssertEqual(arrange.source.verify.saveUser_Void.first?.id, "42")
        XCTAssertEqual(arrange.source.verify.saveUser_Void.first?.email, "test@test.gr")
        XCTAssertEqual(arrange.source.verify.saveUser_Void.first?.name, "Kris")
    }
    
    func testGetUser() {
        // Arrange
        let arrange = arrange()
        arrange.source.stub.loadUser_UserData = { self.user }
        
        // Act
        let receivedUser = arrange.source.loadUser()
        
        // Assert
        XCTAssertEqual(arrange.source.verify.loadUser_UserData.count, 1)
        XCTAssertEqual(receivedUser, user)
        XCTAssertEqual(receivedUser?.id, "42")
        XCTAssertEqual(receivedUser?.email, "test@test.gr")
        XCTAssertEqual(receivedUser?.name, "Kris")
    }
    
    func testGetUserPublisher() throws {
        // Arrange
        let arrange = arrange()
        arrange.source.stub.saveUser_Void = { _ in return () }
        arrange.source.stub.loadUser_UserData = { self.user }
        
        let expectation = XCTestExpectation(description: "Publisher emits user")
        
        var receivedUser: UserData?
        let cancellable = arrange.repo.getUserPublisher()
            .sink { user in
                receivedUser = user
                expectation.fulfill()
            }
        
        // Act
        try arrange.repo.saveUser(user)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedUser, user)
        XCTAssertEqual(arrange.source.verify.saveUser_Void.first, receivedUser)
        XCTAssertEqual(receivedUser?.id, "42")
        XCTAssertEqual(receivedUser?.email, "test@test.gr")
        XCTAssertEqual(receivedUser?.name, "Kris")
        cancellable.cancel()
    }
    
    func testClearUser() {
        // Arrange
        let arrange = arrange()
        arrange.source.stub.loadUser_UserData = { nil }
        
        // Act
        arrange.repo.clearUser()
        let receivedUser = arrange.source.loadUser()
        
        // Assert
        XCTAssertEqual(arrange.source.verify.clear_Void.count, 1)
        XCTAssertNil(receivedUser)
    }
    
    func testClearUserUpdatesPublisher() {
        // Arrange
        let arrange = arrange()
        arrange.source.stub.loadUser_UserData = { nil }
        let expectation = XCTestExpectation(description: "Publisher emits nil")
        
        var receivedUser: UserData? = self.user
        let cancellable = arrange.repo.getUserPublisher()
            .sink { user in
                receivedUser = user
                expectation.fulfill()
            }
     
        // Act
        arrange.repo.clearUser()

        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(receivedUser)
        cancellable.cancel()
    }
    
    func testGetUserPublisherStartsWithNilIfNoUser() {
        // Arrange
        let arrange = arrange()
        arrange.source.stub.loadUser_UserData = { nil }
        
        let expectation = XCTestExpectation(description: "Publisher emits nil")
        var received: UserData??
        
        let cancellable = arrange.repo.getUserPublisher()
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
        let arrange = arrange()
        arrange.source.stub.saveUser_Void = { _ in return () }
        arrange.source.stub.loadUser_UserData = { self.user }
        
        let exp1 = XCTestExpectation(description: "First subscriber")
        let exp2 = XCTestExpectation(description: "Second subscriber")
        
        var user1: UserData?
        var user2: UserData?
        
        let cancellable1 = arrange.repo.getUserPublisher()
            .sink {
                user1 = $0
                exp1.fulfill()
            }
        let cancellable2 = arrange.repo.getUserPublisher()
            .sink {
                user2 = $0
                exp2.fulfill()
            }
        
        // Act
        try arrange.repo.saveUser(user)
        
        // Assert
        wait(for: [exp1, exp2], timeout: 1.0)
        XCTAssertEqual(user1, user)
        XCTAssertEqual(user2, user)
        
        cancellable1.cancel()
        cancellable2.cancel()
    }
    
}
