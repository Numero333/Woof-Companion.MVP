//
//  WalkViewModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation

@MainActor
final class WalkViewModel: ObservableObject {
    
    let walkDataStoreManager = WalkDataStoreManager()
    let authManager = AuthManager()
    @Published var isStarted = false
    @Published var errorMessage: String?
    
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
