//
//  ParametersView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import SwiftUI

struct ParametersView: View {
    
    @EnvironmentObject private var coordinator: CoordinatorManager
    @EnvironmentObject private var authManager: AuthManager
    
    @State private var isLogOutAlertIsPresented =  false
    @State private var isDeleteAlertIsPresented =  false
    
    var body: some View {
        List {
            Button("Se déconnecter") { isLogOutAlertIsPresented.toggle() }
            Button("Supprimer le compte") { isDeleteAlertIsPresented.toggle() }
        }
        .alert("Êtes vous sur de vouloir vous déconnecter ?", isPresented: $isLogOutAlertIsPresented, actions: {
            Button("Oui") {
#warning("refacto")
                do {
                    try authManager.signOut()
                } catch let error {
                    print(error)
                }
                
                coordinator.popToRoot()
            }
            Button("Non") {
                isLogOutAlertIsPresented.toggle()
            }
        })
        .alert("Êtes vous sur de vouloir supprimer votre compte ?", isPresented: $isDeleteAlertIsPresented, actions: {
            Button("Oui") {
#warning("refacto")
                authManager.deleteUser()
                coordinator.popToRoot()
            }
            Button("Non") {
                isLogOutAlertIsPresented.toggle()
            }
        })
    }
}

#Preview {
    ParametersView()
}
