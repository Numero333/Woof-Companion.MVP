//
//  WalkViewModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation

@MainActor
final class WalkViewModel: ObservableObject {
    
    func formatSpeed(speed: String) -> String {
        if let value = Double(speed) {
            let formattedSpeed = String(format: "%.2f", value)
            return formattedSpeed
        } else {
            return "N/A"
        }
    }
}
