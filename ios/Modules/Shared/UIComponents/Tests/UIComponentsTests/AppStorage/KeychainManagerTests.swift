import XCTest
@testable import UIComponents

final class KeychainManagerTests: XCTestCase {
    
    struct TestUser: Codable, Equatable {
        let id: Int
        let name: String
        let email: String
    }
    private let testKey = "test.user"
    private let user = TestUser(id: 42, name: "Kris", email: "test@test.gr")

    override func tearDown() {
          KeychainManager.delete(testKey)
          super.tearDown()
      }
    
    func testSaveAndLoadUser() throws {
        do {
            try KeychainManager.save(user, key: testKey)
        } catch {
            throw XCTSkip("Keychain not available in unit test env: \(error)")
        }
        
        let loadedUser = KeychainManager.load(testKey, as: TestUser.self)
        XCTAssertNotNil(loadedUser)
        XCTAssertEqual(loadedUser, user)
        XCTAssertEqual(loadedUser?.id, 42)
        XCTAssertEqual(loadedUser?.email, "test@test.gr")
        XCTAssertEqual(loadedUser?.name, "Kris")
    }
    
    func testDeleteUserRemovesFromKeychain() throws {
        do {
            try KeychainManager.save(user, key: testKey)
        } catch {
            throw XCTSkip("Keychain not available in unit test env: \(error)")
        }
        
        KeychainManager.delete(testKey)
        let loadedUser = KeychainManager.load(testKey, as: TestUser.self)
        XCTAssertNil(loadedUser)
    }
    
    func testLoadNonExistentKeyReturnsNil() {
        let loadedUser = KeychainManager.load("nonexistent", as: TestUser.self)
        XCTAssertNil(loadedUser)
    }
}
