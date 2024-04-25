//
//  ParametersView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import SwiftUI

struct ParametersView: View {
    
    //MARK: - Properties
    @EnvironmentObject private var coordinator: CoordinatorManager
    @ObservedObject private var vm = AuthentificationViewModel()
    @State private var isLogOutAlertIsPresented =  false
    @State private var isDeleteAlertIsPresented =  false
    
    //MARK: - Body
    var body: some View {
        List {
            Button("Se déconnecter") { isLogOutAlertIsPresented.toggle() }
            Button("Supprimer le compte") {
                isDeleteAlertIsPresented.toggle() }
            .foregroundStyle(.red)
        }
        .alert("Êtes vous sur de vouloir vous déconnecter ?", isPresented: $isLogOutAlertIsPresented, actions: {
            Button("Oui") {
                vm.signOut()
                vm.disconnected = true
                coordinator.isLogged = false
                coordinator.popToRoot()
            }
            Button("Non") {
                isLogOutAlertIsPresented.toggle()
            }
        })
        .alert("Êtes vous sur de vouloir supprimer votre compte ?", isPresented: $isDeleteAlertIsPresented, actions: {
            Button("Oui") {
                vm.deleteUser()
                vm.disconnected = true
                coordinator.isLogged = false
                coordinator.popToRoot()
            }
            Button("Non") {
                isLogOutAlertIsPresented.toggle()
            }
        })
        .onDisappear {
            if vm.disconnected {
                coordinator.isLogged = false
            }
        }
    }
}

#Preview {
    ParametersView()
}
