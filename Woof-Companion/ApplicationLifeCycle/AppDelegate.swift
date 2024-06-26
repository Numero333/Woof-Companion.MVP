//
//  AppDelegate.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    //MARK: - Methods
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        let _ = Firestore.firestore()
        return true
    }
}
