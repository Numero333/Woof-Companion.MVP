//
//  WeatherChoice.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import Foundation

enum WeatherChoice: String, CaseIterable {
    case rain, sun, cloud, storm, wind
    
    var description: String {
            switch self {
            case .rain: return "Pluie"
            case .sun: return "Soleil"
            case .cloud: return "Nuage"
            case .storm: return "Orage"
            case .wind: return "Vent"
            }
        }
}
