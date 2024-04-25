//
//  ResetPasswordView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @EnvironmentObject private var coordinator: CoordinatorManager
    @ObservedObject private var vm = AuthentificationViewModel()
    
    @State private var email =  ""
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            TextField("Email...", text: $email)
            
            Button {
                vm.resetPassword(email: email)
                isPresented.toggle()
            } label: {
                Text("Réinitialiser le mot de passe")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }.padding()
        }
        .alert("Mot de passe réinitialisé", isPresented: $isPresented, actions: {
            Button("OK") {
                coordinator.popToRoot()
            }
        }, message: {
            Text("Un mail vous a été envoyer")
        })
        .navigationTitle("Mot de passe oublié")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    ResetPasswordView()
}
