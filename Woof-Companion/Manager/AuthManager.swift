//
//  AuthManager.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation
import FirebaseAuth

@MainActor
final class AuthManager: ObservableObject {
    
    // MARK: Properties
    @Published var isLogged = false
    @Published var email = ""
    @Published var password = ""
    
//        init() {
//            Auth.auth().currentUser?.delete()
//           try! signOut()
//        }
    
    //MARK: - Methods
    
    // Get the user localy
    func getAuthUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            print("error")
            throw URLError(.userAuthenticationRequired)
        }
        isLogged = true
        return AuthDataResultModel(user: user)
    }
    
    func deleteUser() {
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
            // An error happened.
          } else {
            // Account deleted.
          }
        }
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            isLogged = false
        } catch let error {
            throw error
        }
    }
    
    func signUp() {
        
        guard !email.isEmpty, !password.isEmpty, email.count > 10, password.count > 8 else {
            print("incorrect mail or password check information")
            return
        }
        
        Task {
            do {
                let _ = try await self.createUser(email: email, password: password)
                self.isLogged = true
            } catch let error {
                print("error while logging please try again")
                print(error.localizedDescription)
            }
        }
    }
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty, email.count > 10, password.count > 8 else {
            print("incorrect mail or password check information")
            return
        }
        Task {
            do {
                let _ = try await self.signInUser(email: email, password: password)
                print(email)
                print(password)
                self.isLogged = true
            } catch let error {
                print("error while sign in please try again")
                print(error.localizedDescription)
            }
        }
    }
    
//    func resetPassword() {
//        do {
//            let user = try getAuthUser()
//            guard let email = user.email else {
//                print("cant find email")
//                return
//            }
//            resetPasswordUser(email: email)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
    
    func updateEmail() {
        guard let user = Auth.auth().currentUser else {
            print("cant find user")
            return
        }
        guard let email = user.email else {
            print("cant find user email")
            return
        }
        user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authResult.user)
    }
    
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authResult.user)
    }
    
    func resetPasswordUser(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch let error {
            print("error mail non trouvé")
        }
    }
    
    func debug() {
        self.isLogged =  true
        print(isLogged)
    }
}
