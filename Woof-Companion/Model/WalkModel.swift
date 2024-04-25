//
//  WalkModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation
import FirebaseFirestore

struct WalkModel: Codable {
    var startDate: String = " N/A "
    var distance: Double = 0.0
    var duration: Double = 0.0
    var energy: Int = 0
    var speed: String = " N/A "
    var weather: String = " N/A "
    var totalInSecond: Double = 0.0
    var date: Date = Date()
    var encounter: Int = 0
    
    var value: [String:Any] {
        return [
            "startDate" : startDate,
            "distance" : distance,
            "duration" : duration,
            "energy" : energy,
            "speed" : speed,
            "weather" : weather,
            "totalInSecond" : totalInSecond,
            "date" : date,
            "encounter" : encounter
        ]
    }
    
    static func from(dictionary: [String: Any]) -> WalkModel {
            let startDate = dictionary["startDate"] as? String ?? "N/A"
            let distance = dictionary["distance"] as? Double ?? 0.0
            let duration = dictionary["duration"] as? Double ?? 0.0
            let energy = dictionary["energy"] as? Int ?? 0
            let speed = dictionary["speed"] as? String ?? "N/A"
            let weather = dictionary["weather"] as? String ?? "N/A"
            let totalInSecond = dictionary["totalInSecond"] as? Double ?? 0.0
            let date = (dictionary["date"] as? Timestamp)?.dateValue() ?? Date()
            let encounter = dictionary["encounter"] as? Int ?? 0
            
            return WalkModel(startDate: startDate, distance: distance, duration: duration, energy: energy, speed: speed, weather: weather, totalInSecond: totalInSecond, date: date, encounter: encounter)
        }
}
