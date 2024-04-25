//
//  AuthView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import SwiftUI

struct AuthView: View {
    
    //MARK: - Properties
    @EnvironmentObject private var coordinator: CoordinatorManager
    
    //MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "pawprint.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .background()
            
            Spacer()
            
            Text("L'application qui vous aide au quotidien avec votre chien 🐶")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            VStack(spacing: 10) {
                Button {
                    coordinator.push(.signUp)
                } label: {
                    Text("Créer un compte")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Divider()
                Button {
                    coordinator.push(.signIn)
                } label: {
                    Text("Se connecter")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .navigationTitle("Woof Companion")
        .navigationBarTitleDisplayMode(.large)
        .padding()
    }
}

#Preview {
    AuthView()
}
