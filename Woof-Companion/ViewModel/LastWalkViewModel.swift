//
//  LastWalkViewModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 26/04/2024.
//

import Foundation

class LastWalkViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var lastWalk: WalkModel?
    @Published var errorMessage: String?
    private var walkStored: [WalkModel] = []
    private var walkDataStoreManager: WalkDataStoreManager
    private var authManager: AuthManager
    private var user: AuthDataResultModel?
    
    //MARK: - Initialization
    init(walkDataStoreManager: WalkDataStoreManager = WalkDataStoreManager(), authManager: AuthManager = AuthManager()){
        self.walkDataStoreManager = walkDataStoreManager
        self.authManager = authManager
    }
    
    var energy: String {
        guard let energy = self.lastWalk?.energy else { return "N/A"}
        return String(describing: energy) + " %"
    }
    
    var weather: String {
        guard let weather = self.lastWalk?.weather else { return "N/A" }
        return String(describing: weather)
    }
    
    var encounter: String {
        guard let encounter = self.lastWalk?.encounter else { return "N/A" }
        return String(describing: encounter)
    }
    
    var startDate: String {
        guard let startDate = self.lastWalk?.startDate else { return "N/A" }
        return String(describing: startDate)
    }
    
    var duration: String {
        return formatTime()
    }
    
    var distance: String {
        guard let distance = self.lastWalk?.distance else { return "N/A" }
        
        return formatDistance(distance: distance) + " km"
    }
    
    //MARK: - Methods
    func fetch() {
        walkStored = []
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
                DispatchQueue.main.async {
                    self.lastWalk = self.walkStored.first
                }
            } catch let error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    //MARK: - Private
    private func formatDistance(distance: Double) -> String {
        let kilometers = distance / 1000.0
        let formattedDistance = String(format: "%.2f", kilometers)
        return formattedDistance
    }
    
    private func formatTime() -> String {
        guard let seconds = self.lastWalk?.duration else { return "N/A" }
        let convertedSecond = Int(seconds)
        let hours = convertedSecond / 3600
        let minutes = (convertedSecond % 3600) / 60
        let hourString = hours > 0 ? "\(hours)h" : ""
        let minuteString = "\(minutes)m"
        return hourString + minuteString
    }
}
