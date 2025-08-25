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

final class AuthAPISourceTests: XCTestCase {
    private func getSource() -> (AuthAPISource) {
        AuthAPISourceImpl()
    }
    
    private let user = UserData(id: "123", email: "test@test.gr", name: "Kris", token: "123")

    func testLogin() async throws {
        // Arrange
        let source = getSource()
        
        // Act
        let loadedUser = try await source.login(email: user.email, password: "123")
        
        // Assert
        XCTAssertNil(loadedUser)
    }
    
    func testSignUp() async throws {
        // Arrange
        let source = getSource()

        // Act
        let loadedUser = try await source.signup(name: user.name, email: user.email, password: "123")
        
        // Assert
        XCTAssertNil(loadedUser)
    }
    
    func testForgotPassword() async throws {
        // Arrange
        let source = getSource()

        // Act
        let loadedUser = try await source.forgotPassword(email: user.email)
        
        // Assert
        XCTAssertNil(loadedUser)
        
//        func testForgotPasswordCall() async throws {
//            let mockClient = MockHTTPClient()
//            
//            // Stub logic: επιστρέφει fake response
//            mockClient.stub = { path, method, body, headers in
//                if path == "/forgot-password" && method == .post {
//                    return RAuthResponseForgotPassword(message: "Email sent")
//                }
//                throw GenericAPIError(code: "404", message: "Not Found")
//            }
//            
//            let authAPI = AuthAPISourceImpl(client: mockClient)
//            
//            let message = try await authAPI.forgotPassword(email: "test@test.com")
//            XCTAssertEqual(message, "Email sent")
//            
//            // Verify call
//            XCTAssertTrue(mockClient.verifyCalled(path: "/forgot-password", method: .post, body: ["email": "test@test.com"]))
//        }
    }
}
