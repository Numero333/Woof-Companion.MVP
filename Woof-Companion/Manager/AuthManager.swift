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
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        isLogged = true
        return AuthDataResultModel(user: authResult.user)
    }
    
    // Get the user localy
    func getAuthUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            print("error")
            throw URLError(.userAuthenticationRequired)
        }
        isLogged = true
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw URLError(.userAuthenticationRequired)
        }
    }
    
    func signUp() {
        
        guard !email.isEmpty, !password.isEmpty, email.count > 10, password.count > 8 else {
            print("incorrect mail or password check information")
            return
        }
        
        Task {
            do {
                let userData = try await self.createUser(email: email, password: password)
                self.isLogged = true
            } catch {
                print("error while logging please try again")
            }
        }
    }
    
    func debug() {
        self.isLogged =  true
        print(isLogged)
    }
}
