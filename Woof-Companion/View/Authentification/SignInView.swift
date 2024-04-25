//
//  SignInView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import SwiftUI

struct SignInView: View {
    
    //MARK: - Properties
    @EnvironmentObject private var coordinator: CoordinatorManager
    @ObservedObject private var vm = AuthentificationViewModel()
    @FocusState private var isFocused
    @State private var showAlert = false
    
    //MARK: - Body
    var body: some View {
        Spacer()
        ScrollView {
            Spacer()
            TextField("Mail...", text: $vm.email)
                .textInputAutocapitalization(.never)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .focused($isFocused)
                .padding(.horizontal)
            
            SecureField("Password...", text: $vm.password)
                .textInputAutocapitalization(.never)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .padding(.horizontal)

        
                Button {
                    vm.signIn()
                } label: {
                    Text("Se connecter")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button {
                    coordinator.push(.resetPassword)
                } label: {
                    Text("Mot de passe oublié ?")
                }
                .padding(.top)
        }
        
        .navigationTitle("Se connecter")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear {
            isFocused = true
        }
        .onDisappear {
            vm.clearTextInput()
        }
        .onChange(of: vm.isLogged) { _ in
            coordinator.isLogged = vm.isLogged
        }
        .onReceive(vm.$errorMessage, perform: { _ in
            if vm.errorMessage != nil {
                showAlert = true
            }
        })
        .alert("Erreur",
               isPresented: $showAlert) {
            Button("Okay") {
                showAlert.toggle()
            }
        } message: {
            Text(vm.errorMessage?.description ?? "Une erreur inconnu est survenu")
        }
    }
}

#Preview {
    SignInView()
}
