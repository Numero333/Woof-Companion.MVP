//
//  Woof_CompanionApp.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI
import Firebase

@main
struct Woof_CompanionApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
    }
}
