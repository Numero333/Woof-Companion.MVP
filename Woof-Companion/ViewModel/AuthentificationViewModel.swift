//
//  AuthentificationViewModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 25/04/2024.
//

import Foundation
import SwiftUI

@MainActor
protocol AuthenticationViewModelProtocol: AnyObject {
    var email: String { get set }
    var password: String { get set }
    var isLogged: Bool { get }
    var disconnected: Bool { get set }
    var errorMessage: String? { get set }

    func signUp()
    func signIn()
    func signOut()
    func deleteUser()
    func updateEmail(email: String)
    func resetPassword(email: String)
    func clearTextInput()
}


@MainActor
final class AuthentificationViewModel: AuthenticationViewModelProtocol, ObservableObject {
    
    // MARK: - Properties
    @Published var authManager: AuthManager
    @Published var errorMessage: String?
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLogged: Bool = false
    @Published var disconnected: Bool = false
    
    //MARK: - Initialization
    init(authManager: AuthManager = AuthManager()){
        self.authManager = authManager
    }
    
    // MARK: - Methods
    
    // Attempt to sign up the user
    func signUp() {
        Task {
            do {
                try await authManager.signUp(email: email, password: password)
                isLogged = true
            } catch let error {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Attempt to sign in the user
    func signIn() {
        Task {
            do {
                try await authManager.signIn(email: email, password: password)
                isLogged = true
            } catch let error {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Sign out the user
    func signOut() {
        Task {
            do {
                try await authManager.signOut()
                isLogged = false
            } catch let error {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Delete the user
    func deleteUser() {
        Task {
            do {
                try await authManager.deleteUser()
                isLogged = false
            } catch let error {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Update user's email
    func updateEmail(email: String) {
        Task {
            do {
                try await authManager.updateEmail(email: email)
                isLogged = false
            } catch let error {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Reset password
    func resetPassword(email: String) {
        Task {
            do {
                try await authManager.resetPassword(email: email)
                isLogged = false
            } catch let error {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Reset email and password input
    func clearTextInput() {
        self.email = ""
        self.password = ""
    }
}
