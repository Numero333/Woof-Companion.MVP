//
//  WalkViewModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation

final class WalkViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var isStarted = false
    @Published var errorMessage: String?
    
    let walkDataStoreManager: WalkDataStoreManager
    let authManager: AuthManager
    
    //MARK: - Initialization
    init(walkDataStoreManager: WalkDataStoreManager = WalkDataStoreManager(), authManager: AuthManager = AuthManager()){
        self.walkDataStoreManager = walkDataStoreManager
        self.authManager = authManager
    }
    
    //MARK: - Methods
    func addWalk(for walkModel: WalkModel) {
        Task {
            do {
                let user = try authManager.getAuthUser()
                try await walkDataStoreManager.addNewWalkForUser(user: user, walkData: walkModel)
            } catch let error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func formatSpeed(speed: String) -> String {
        if let value = Double(speed) {
            let formattedSpeed = String(format: "%.2f", value)
            return formattedSpeed
        } else {
            return "N/A"
        }
    }
}
