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
        
        VStack {
            TotalActivityView()
            LastWalkView()
            
            Button {
                coordinator.push(.history)
            } label: {
                Text("Navigation Test")
            }
            
            Button {
                authManager.isLogged = false
            } label: {
                Text("Navigation Test")
            }
        }
        .frame(maxHeight: .infinity)        
    }
}

#Preview {
    MainView()
}
