//
//  FirestoreManager.swift
//  Woof-Companion
//
//  Created by François-Xavier on 25/04/2024.
//

import Foundation
import FirebaseFirestore

final class FirestoreManager {
    
    let db = Firestore.firestore()

    // Création ou mise à jour d'un document
    func setDocument(collectionPath: String, documentId: String, data: [String: Any]) async throws {
        let documentRef = db.collection(collectionPath).document(documentId)
        try await documentRef.setData(data)
    }

    // Récupération d'un document spécifique
    func getDocument(collectionPath: String, documentId: String) async throws -> DocumentSnapshot {
        let documentRef = db.collection(collectionPath).document(documentId)
        let documentSnapshot = try await documentRef.getDocument()
        if documentSnapshot.exists {
            return documentSnapshot
        } else {
            throw NSError(domain: "FirestoreError", code: 404, userInfo: ["message": "Document not found"])
        }
    }

    // Suppression d'un document
    func deleteDocument(collectionPath: String, documentId: String) async throws {
        let documentRef = db.collection(collectionPath).document(documentId)
        try await documentRef.delete()
    }

    // Récupération de tous les documents dans une collection
    func getAllDocuments(collectionPath: String) async throws -> [QueryDocumentSnapshot] {
        let collectionRef = db.collection(collectionPath)
        let querySnapshot = try await collectionRef.getDocuments()
        return querySnapshot.documents
    }
}
