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
    private var walkDataStoreManager = WalkDataStoreManager()
    private var auth = AuthManager()
    @Published var walkStored: [WalkModel] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    private var user: AuthDataResultModel?
    
    
    
    //MARK: - Methods
    func fetchAll() {
        walkStored = []
        isLoading = true
        Task {
            do {
                self.user = try auth.getAuthUser()
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
