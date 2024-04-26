//
//  TotalActivityViewModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 26/04/2024.
//

import Foundation

final class TotalActivityViewModel: ObservableObject {
        
    //MARK: - Properties
    @Published var recentWalks: [WalkModel] = []
    @Published var errorMessage: String?
    private var walkDataStoreManager: WalkDataStoreManager
    private var authManager: AuthManager
    private var user: AuthDataResultModel?
    
    //MARK: - Initialization
    init(walkDataStoreManager: WalkDataStoreManager = WalkDataStoreManager(), authManager: AuthManager = AuthManager()){
        self.walkDataStoreManager = walkDataStoreManager
        self.authManager = authManager
    }
    
    var energy: String {
        return calculateEnergy()
    }
    
    var distance: String {
        return calculateDistance()
    }
    
    var duration: String {
        return calculateDuration()
    }
    
    var encouter: String {
        return calculateEncounter()
    }
    
    //MARK: - Methods
    func fetch() {
        
        let calendar = Calendar.current
        let twentyFourHoursAgo = calendar.date(byAdding: .hour, value: -24, to: Date())!
        
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
                        if walkDataDecoded.date >= twentyFourHoursAgo {
                            DispatchQueue.main.async {
                                self.recentWalks.append(walkDataDecoded)
                            }
                        }
                    }
                }
            } catch let error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    //MARK: - Private
    private func calculateEnergy() -> String {
        var totalEnergy = recentWalks.reduce(0) { $0 + Int($1.energy) }
        if recentWalks.count > 0 {
            totalEnergy = totalEnergy / recentWalks.count
        }
        return String(totalEnergy) + " %"
    }
    
    private func calculateDistance() -> String {
        let totalDistance = round(recentWalks.reduce(0) { $0 + $1.distance })
        return formatDistance(distance: totalDistance) + " km"
    }

    private func calculateDuration() -> String {
        let totalDuration = round(recentWalks.reduce(0) { $0 + $1.duration })
        return formatTime(seconds: totalDuration)
    }

    private func calculateEncounter() -> String {
        let totalEncounter = recentWalks.reduce(0) { $0 + $1.encounter }
        return String(totalEncounter)
    }
    
    private func formatDistance(distance: Double) -> String {
        let kilometers = distance / 1000.0
        let formattedDistance = String(format: "%.2f", kilometers)
        return formattedDistance
    }
    
    private func formatTime(seconds: Double) -> String {
        let convertedSecond = Int(seconds)
        let hours = convertedSecond / 3600
        let minutes = (convertedSecond % 3600) / 60
        let hourString = hours > 0 ? "\(hours)h " : ""
        let minuteString = "\(minutes)m"
        return hourString + minuteString
    }
}
