//
//  MainView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var coordinator: CoordinatorManager
    @EnvironmentObject private var authManager: AuthManager
    
    var body: some View {
        
        NavigationView {
            VStack {
                TotalActivityView()
                LastWalkView()
                Spacer()
                Button {
                    authManager.isLogged = false
                } label: {
                    Text("Navigation Test")
                }
            }
            .frame(maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        coordinator.push(.parameters)
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black.opacity(0.4))
                            .font(.title3)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "pawprint")
                        Text("Woof Companion")
                    }
                    .font(.headline)
                }
        }
        }
    }
}

#Preview {
    MainView()
}
