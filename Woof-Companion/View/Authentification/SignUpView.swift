//
//  SignUpView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import SwiftUI
import AuthenticationServices

struct SignUpView: View {
    
    @EnvironmentObject private var coordinator: CoordinatorManager
    @EnvironmentObject private var authManager: AuthManager
    
    @FocusState private var isFocused
    
    var body: some View {
        VStack {
            TextField("Mail...", text: $authManager.email)
                .textInputAutocapitalization(.never)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .focused($isFocused)
            
            SecureField("Password...", text: $authManager.password)
                .textInputAutocapitalization(.never)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            Button {
                authManager.signUp()
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button {
                coordinator.pop()
                coordinator.push(.signIn)
            } label: {
                Text("Vous avez déja un compte ?")
            }
            .padding(.top)
            
        }
        .navigationTitle("Créer un compte")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear {
            isFocused = true
        }
        .onDisappear {
            authManager.email = ""
            authManager.password = ""
        }
    }
}

#Preview {
    SignUpView()
}
