//
//  Coordinator.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

enum AppView: String, Identifiable {
    case main, walk, history
    
    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {
    case finishedWalk
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var fullScreenCover: FullScreenCover?
    @Published var selectedTab: AppView = .main
    
    func push(_ appView: AppView) {
        path.append(appView)
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(appView: AppView) -> some View {
        switch appView {
        case .main:
            MainView()
        case .walk:
            WalkView()
        case .history:
            HistoryView()
        }
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .finishedWalk:
            FinishedWalkView()
        }
    }
}
