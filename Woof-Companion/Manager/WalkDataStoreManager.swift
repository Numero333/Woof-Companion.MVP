//
//  WalkDataStoreManager.swift
//  Woof-Companion
//
//  Created by François-Xavier on 25/04/2024.
//

import Foundation
import FirebaseFirestore

final class WalkDataStoreManager {
    
    private let firestoreManager: FirestoreManager
    
    init(fireStoreManager: FirestoreManager = FirestoreManager()) {
        self.firestoreManager = fireStoreManager
    }
    
    // Create a new document for the user
    func createNewDocumentForUser(user: AuthDataResultModel) async throws {
        var userData: [String : Any] = ["uid": user.uid]
        if let userEmail = user.email {
            userData["email"] = userEmail
        }
        try await firestoreManager.setDocument(collectionPath: "users", documentId: user.uid, data: userData)
    }
    
    // Add a new walk for the user
    func addNewWalkForUser(user: AuthDataResultModel, walkData: WalkModel) async throws {
        try await firestoreManager.setDocument(collectionPath: "users/\(user.uid)/walk", documentId: Date().description, data: walkData.value)
    }
    
    // Fetch all walks of the user
    func fetchAllWalksForUser(uid: String) async throws -> [QueryDocumentSnapshot] {
        return try await firestoreManager.getAllDocuments(collectionPath: "users/\(uid)/walk")
    }
    
    // Get a specific walk by id
    func fetchWalkById(uid: String, walkId: String) async throws -> DocumentSnapshot {
        return try await firestoreManager.getDocument(collectionPath: "users/\(uid)/walk", documentId: walkId)
    }
    
    // Delete a specific walk by id
    func deleteWalkById(uid: String, walkId: String) async throws {
        try await firestoreManager.deleteDocument(collectionPath: "users/\(uid)/walk", documentId: walkId)
    }
}


