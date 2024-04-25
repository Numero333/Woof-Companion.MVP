//
//  AuthManager.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation
import FirebaseAuth
import FirebasePerformance

final class AuthManager: ObservableObject {
    
    // MARK: - Properties
    @Published var isLogged = false
    
    private let walkDataStoreManager: WalkDataStoreManager
    
    //MARK: - Initialization
    init(walkDataStoreManager: WalkDataStoreManager = WalkDataStoreManager()) {
        self.walkDataStoreManager = walkDataStoreManager
    }
    
    // MARK: - Methods
    
    // Get the currently authenticated user
    func getAuthUser() throws -> AuthDataResultModel {
        let trace = Performance.startTrace(name: "getAuthUser")
        defer { trace?.stop() }
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        isLogged = true
        return AuthDataResultModel(user: user)
    }
    
    // Sign Out the currently authenticated user
    func signOut() async throws {
        let trace = Performance.startTrace(name: "signOut")
        defer { trace?.stop() }
        try Auth.auth().signOut()
        isLogged = false
    }
    
    // Sign Up the user
    func signUp(email: String, password: String) async throws {
        let trace = Performance.startTrace(name: "signUp")
        defer { trace?.stop() }
        let (email, password) = try checkInformation(email: email, password: password)
        let _ = try await createUser(email: email, password: password)
        let user = try getAuthUser()
        try await walkDataStoreManager.createNewDocumentForUser(user: user)
        self.isLogged = true
    }
    
    // Sign In the user and check mail and password
    func signIn(email: String, password: String) async throws {
        let trace = Performance.startTrace(name: "signIn")
        defer { trace?.stop() }
        let (email, password) = try checkInformation(email: email, password: password)
        let _ = try await signInUser(email: email, password: password)
        self.isLogged = true
    }
    
    // mail update for the authenticated user
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser, let _ = user.email else {
            throw NSError(domain: "AuthError", code: 1004, userInfo: [NSLocalizedDescriptionKey: "Aucun utilisateur associé a cette adresse."])
        }
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    // Delete the currently authenticated user
    func deleteUser() async throws {
        let trace = Performance.startTrace(name: "deleteUser")
        defer { trace?.stop() }
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "AuthError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "User non connecté."])
        }
        try await user.delete()
        self.isLogged = false
    }
    
    // Reset password for the authenticated user by mail
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    //MARK: - Private
    
    private func checkInformation(email: String, password: String) throws -> (String,String) {
        guard !email.isEmpty, !password.isEmpty, email.count > 10, password.count > 8 else {
            throw NSError(domain: "AuthError", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Invalide email ou password."])
        }
        return (email, password)
    }
    
    // Sing In the user
    private func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authResult.user)
    }
    
    // Create a new user in our database
    private func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authResult.user)
    }
}
