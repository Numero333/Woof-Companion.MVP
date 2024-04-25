//
//  CoordinatorManager.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

//MARK: - Base View
enum AppView: String, Identifiable {
    case main, walk, history, auth
    
    var id: String {
        self.rawValue
    }
}

//MARK: - Sub View
enum SubView: String, Identifiable {
    case signUp, signIn, resetPassword, parameters
    
    var id: String {
        self.rawValue
    }
}

//MARK: - FullScreenCover View
enum FullScreenCover: String, Identifiable {
    case finishedWalk
    
    var id: String {
        self.rawValue
    }
}

//MARK: - Coordinator Manager
final class CoordinatorManager: ObservableObject {
    
    // MARK: Properties
    @Published var path = NavigationPath()
    @Published var fullScreenCover: FullScreenCover?
    @Published var selectedTab: AppView = .main
    @Published var isLogged: Bool = false
    
    //MARK: - Methods
    func push(_ subView: SubView) {
        path.append(subView)
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
    
    //MARK: - View Builder
    @ViewBuilder
    func build(appView: AppView) -> some View {
        switch appView {
        case .main:
            MainView()
        case .walk:
            WalkView()
        case .history:
            HistoryView()
        case .auth:
            AuthView()
        }
    }
    
    @ViewBuilder
    func build(subView: SubView) -> some View {
        switch subView {
        case .signUp:
            SignUpView()
        case .signIn:
            SignInView()
        case .resetPassword:
            ResetPasswordView()
        case .parameters:
            ParametersView()
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
