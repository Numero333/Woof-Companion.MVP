//
//  FirestoreManager.swift
//  Woof-Companion
//
//  Created by François-Xavier on 25/04/2024.
//

import Foundation
import FirebaseFirestore
import FirebasePerformance

final class FirestoreManager {
    
    // Init Data base
    private let db: Firestore
    
    init(db: Firestore = Firestore.firestore()){
        self.db = db
    }
    
    // Create a document
    func setDocument(collectionPath: String, documentId: String, data: [String: Any]) async throws {
        let trace = Performance.startTrace(name: "createDocument")
        defer { trace?.stop() }
        let documentRef = db.collection(collectionPath).document(documentId)
        try await documentRef.setData(data)
    }
    
    // Fetch a specific document
    func getDocument(collectionPath: String, documentId: String) async throws -> DocumentSnapshot {
        let trace = Performance.startTrace(name: "getDocument")
        defer { trace?.stop() }
        let documentRef = db.collection(collectionPath).document(documentId)
        let documentSnapshot = try await documentRef.getDocument()
        if documentSnapshot.exists {
            return documentSnapshot
        } else {
            throw NSError(domain: "FirestoreError", code: 404, userInfo: ["message": "Une erreur est survenu"])
        }
    }
    
    // Delete a document
    func deleteDocument(collectionPath: String, documentId: String) async throws {
        let trace = Performance.startTrace(name: "deleteDocument")
        defer { trace?.stop() }
        let documentRef = db.collection(collectionPath).document(documentId)
        try await documentRef.delete()
    }
    
    // Fetch all document
    func getAllDocuments(collectionPath: String) async throws -> [QueryDocumentSnapshot] {
        let trace = Performance.startTrace(name: "getAllDocument")
        defer { trace?.stop() }
        let collectionRef = db.collection(collectionPath)
        let querySnapshot = try await collectionRef.getDocuments()
        return querySnapshot.documents
    }
}
