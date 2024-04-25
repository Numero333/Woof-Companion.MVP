//
//  WalkDataStoreManager.swift
//  Woof-Companion
//
//  Created by François-Xavier on 25/04/2024.
//

import Foundation
import FirebaseFirestore

final class WalkDataStoreManager {
    
    private let firestoreManager = FirestoreManager()
    
    // Créer un nouveau document pour l'utilisateur
    func createNewDocumentForUser(user: AuthDataResultModel) async throws {
        var userData: [String : Any] = ["uid": user.uid]
        if let userEmail = user.email {
            userData["email"] = userEmail
        }
        try await firestoreManager.setDocument(collectionPath: "users", documentId: user.uid, data: userData)
    }
    
    // Ajouter une nouvelle promenade pour un utilisateur
    func addNewWalkForUser(user: AuthDataResultModel, walkData: [String: String]) async throws {
        guard walkData["date"] != nil, walkData["distance"] != nil, walkData["duration"] != nil, walkData["location"] != nil, walkData["weather"] != nil else {
            throw NSError(domain: "InvalidWalkData", code: 400, userInfo: ["message": "Missing walk data attributes"])
        }
        try await firestoreManager.setDocument(collectionPath: "users/\(user.uid)/walk", documentId: UUID().uuidString, data: walkData)
    }
    
    // Récupérer toutes les promenades d'un utilisateur
    func fetchAllWalksForUser(uid: String) async throws -> [QueryDocumentSnapshot] {
        return try await firestoreManager.getAllDocuments(collectionPath: "users/\(uid)/walk")
    }
    
    // Récupérer une promenade spécifique par son ID
    func fetchWalkById(uid: String, walkId: String) async throws -> DocumentSnapshot {
        return try await firestoreManager.getDocument(collectionPath: "users/\(uid)/walk", documentId: walkId)
    }
    
    // Supprimer une promenade spécifique
    func deleteWalkById(uid: String, walkId: String) async throws {
        try await firestoreManager.deleteDocument(collectionPath: "users/\(uid)/walk", documentId: walkId)
    }
}


