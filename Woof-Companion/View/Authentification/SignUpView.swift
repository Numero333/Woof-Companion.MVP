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
    
    var body: some View {
        VStack(spacing: 30) {
            
            TextField("Mail...", text: $authManager.email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            SecureField("Password...", text: $authManager.password)
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
//                vm.debug()
                authManager.debug()
            } label: {
                Text("Debug")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Se connecter")
        .padding()
    }
}

#Preview {
    SignUpView()
}
