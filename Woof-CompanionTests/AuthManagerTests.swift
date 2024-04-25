//
//  AuthManagerTests.swift
//  Woof-CompanionTests
//
//  Created by François-Xavier on 25/04/2024.
//

import XCTest

import XCTest
import Firebase
import FirebaseAuth
@testable import Woof_Companion

class AuthManagerTests: XCTestCase {

    var authManager: AuthManager!

    @MainActor
    override func setUp() {
        super.setUp()
        authManager = AuthManager()
    }

    override func tearDown() {
        authManager = nil
        super.tearDown()
    }

    @MainActor
    func testGetAuthUser_Success() {
        // Given
        let mockUser = MockUser()
        Auth.auth().overrideCurrentUser(to: mockUser)
        
        // When
        do {
            let authUser = try authManager.getAuthUser()
            
            // Then
            XCTAssertEqual(authUser.uid, mockUser.uid, "Auth user UID should be equal to mock user UID")
            XCTAssertEqual(authUser.email, mockUser.email, "Auth user email should be equal to mock user email")
            XCTAssertTrue(authManager.isLogged, "isLogged should be true after getting auth user")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetAuthUser_NoCurrentUser() {
        // Given
        Auth.auth().overrideCurrentUser(to: nil)
        
        // When
        do {
            _ = try authManager.getAuthUser()
            
            // Then
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError, "Error should be of type URLError")
            XCTAssertEqual((error as? URLError)?.code, .userAuthenticationRequired, "Error code should be userAuthenticationRequired")
        }
    }

    // Implement other tests similarly...
}
