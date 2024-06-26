//
//  CoordinatorView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

// A view that manages navigation and tabbed interface using a coordinator pattern.
struct CoordinatorView: View {
    
    // StateObject to manage the state and logic of navigation throughout the app.
    
    //MARK: - Properties
    @StateObject private var coordinator = CoordinatorManager()
    @ObservedObject private var appModel = AppModel()
    private var authManager = AuthManager()
    
    var body: some View {
        
        // Navigation stack to manage navigable views controlled by the coordinator.
        NavigationStack(path: $coordinator.path) {
            
            if !coordinator.isLogged {
                coordinator.build(appView: .auth)
                
                // Navigation destination for managing transitions.
                    .navigationDestination(for: SubView.self) { subView in
                        coordinator.build(subView: subView)
                    }
                    .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                        coordinator.build(fullScreenCover: fullScreenCover)
                    }
                
            } else {
                
                // Tab view for handling user navigation between different app sections.
                TabView(selection: $coordinator.selectedTab) {
                    CoordinatorTabView(tab: .history)
                        .tabItem {
                            Label("Historique", systemImage: "clock")
                        }
                        .tag(AppView.history)
                    
                    CoordinatorTabView(tab: .main)
                        .tabItem {
                            Label("Accueil", systemImage: "house")
                        }
                        .tag(AppView.main)
                    
                    CoordinatorTabView(tab: .walk)
                        .tabItem {
                            Label("Ballade", systemImage: "figure.walk.motion")
                        }
                        .tag(AppView.walk)
                }
                
                // Navigation destination for managing transitions.
                .navigationDestination(for: SubView.self) { subView in
                    coordinator.build(subView: subView) // Builds the appropriate view.
                }
                // Full screen cover for presenting modal views.
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                    coordinator.build(fullScreenCover: fullScreenCover)
                }
            }
        }
        
        // React of user LogIn / LogOut
        .onChange(of: coordinator.isLogged) { _ in
            coordinator.popToRoot()
        }
        
        // Injects the coordinator as an environment object available to child views.
        .environmentObject(coordinator)
        .environmentObject(appModel)
        .onAppear {
            let authUser = try? authManager.getAuthUser()
            coordinator.isLogged = authUser == nil ? false : true
        }
    }
}

// Represents a tab view managed by the coordinator with specific content.
struct CoordinatorTabView: View {
    @EnvironmentObject var coordinator: CoordinatorManager
    let tab: AppView // Specifies the type of content to build.
    var body: some View {
        // Constructs the view based on the specified tab.
        switch tab {
        case .main:
            coordinator.build(appView: .main)
        case .walk:
            coordinator.build(appView: .walk)
        case .history:
            coordinator.build(appView: .history)
        case .auth:
            coordinator.build(appView: .auth)
        }
    }
}

#Preview {
    CoordinatorView()
}
