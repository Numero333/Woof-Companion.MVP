//
//  AuthView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject private var coordinator: CoordinatorManager
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "house")
                .resizable()
                .frame(width: 200, height: 200)
                .background()
            
            Spacer()
            
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
            
            Button {

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
        .padding()
    }
}

#Preview {
    AuthView()
}
