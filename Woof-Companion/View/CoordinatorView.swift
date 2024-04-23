//
//  CoordinatorView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
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
                    }
                    .tag(AppView.walk)
            }
            .navigationDestination(for: AppView.self) { appView in
                coordinator.build(appView: appView)
            }
            .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                coordinator.build(fullScreenCover: fullScreenCover)
            }
        }
        .environmentObject(coordinator)
    }
}

struct CoordinatorTabView: View {
    @EnvironmentObject var coordinator: Coordinator
    let tab: AppView
    
    var body: some View {
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
