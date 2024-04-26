//
//  AppModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 25/04/2024.
//

import Foundation

final class AppModel: ObservableObject {
    
    //MARK: - Properties
    @Published var walkModel = WalkModel()
}
