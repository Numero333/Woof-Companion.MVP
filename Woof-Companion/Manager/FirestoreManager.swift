//
//  FirestoreManager.swift
//  Woof-Companion
//
//  Created by François-Xavier on 25/04/2024.
//

import Foundation
import FirebaseFirestore

final class FirestoreManager {
    
    // Init Data base
    let db = Firestore.firestore()

    // Create a document
    func setDocument(collectionPath: String, documentId: String, data: [String: Any]) async throws {
        let documentRef = db.collection(collectionPath).document(documentId)
        try await documentRef.setData(data)
    }

    // Fetch a specific document
    func getDocument(collectionPath: String, documentId: String) async throws -> DocumentSnapshot {
        let documentRef = db.collection(collectionPath).document(documentId)
        let documentSnapshot = try await documentRef.getDocument()
        if documentSnapshot.exists {
            return documentSnapshot
        } else {
            throw NSError(domain: "FirestoreError", code: 404, userInfo: ["message": "Document not found"])
        }
    }

    // Delete a document
    func deleteDocument(collectionPath: String, documentId: String) async throws {
        let documentRef = db.collection(collectionPath).document(documentId)
        try await documentRef.delete()
    }

    // Fetch all document
    func getAllDocuments(collectionPath: String) async throws -> [QueryDocumentSnapshot] {
        let collectionRef = db.collection(collectionPath)
        let querySnapshot = try await collectionRef.getDocuments()
        return querySnapshot.documents
    }
}
