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
    @StateObject private var coordinator = CoordinatorManager()
    
    var body: some View {
        // Navigation stack to manage navigable views controlled by the coordinator.
        NavigationStack(path: $coordinator.path) {
            // Tab view for handling user navigation between different app sections.
            TabView(selection: $coordinator.selectedTab) {
                CoordinatorTabView(tab: .history)
                    .tabItem {
                        Label("History", systemImage: "clock")
                    }
                    .tag(AppView.history)
                
                CoordinatorTabView(tab: .main)
                    .tabItem {
                        Label("Main", systemImage: "house")
                    }
                    .tag(AppView.main)
                
                CoordinatorTabView(tab: .walk)
                    .tabItem {
                        Label("Walk", systemImage: "figure.walk.motion")
                            .tag(AppView.walk)
                    }
                // Navigation destination for managing transitions.
                    .navigationDestination(for: AppView.self) { appView in
                        coordinator.build(appView: appView) // Builds the appropriate view.
                    }
                // Full screen cover for presenting modal views.
                    .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                        coordinator.build(fullScreenCover: fullScreenCover)
                    }
            }
            // Injects the coordinator as an environment object available to child views.
            .environmentObject(coordinator)
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
        }
    }
}

#Preview {
    CoordinatorView()
}

