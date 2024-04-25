//
//  HistoryViewModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 25/04/2024.
//

import Foundation

@MainActor
final class HistoryViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var walkStored: [WalkModel] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    private var walkDataStoreManager: WalkDataStoreManager
    private var authManager: AuthManager
    private var user: AuthDataResultModel?
    
    //MARK: - Initialization
    init(walkDataStoreManager: WalkDataStoreManager = WalkDataStoreManager(), authManager: AuthManager = AuthManager()){
        self.walkDataStoreManager = walkDataStoreManager
        self.authManager = authManager
    }
    
    //MARK: - Methods
    func fetchAll() {
        walkStored = []
        isLoading = true
        Task {
            do {
                self.user = try authManager.getAuthUser()
                guard let user = user else {
                    self.errorMessage = NSError(domain: "History", code: -1).localizedDescription
                    return
                }
                let walksReceived = try await walkDataStoreManager.fetchAllWalksForUser(uid: user.uid)
                for walk in walksReceived {
                    let walkReceived = try await walkDataStoreManager.fetchWalkById(uid: user.uid, walkId: walk.documentID)
                    if let data = walkReceived.data() {
                        let walkDataDecoded = WalkModel.from(dictionary: data)
                        walkStored.append(walkDataDecoded)
                    }
                }
                walkStored = walkStored.reversed()
                isLoading = false
            } catch let error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func delete(id: String) {
        Task {
            do {
                guard let user = user else {
                    self.errorMessage = NSError(domain: "History", code: -1).localizedDescription
                    return
                }
                try await walkDataStoreManager.deleteWalkById(uid: user.uid, walkId: id)
            } catch let error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
