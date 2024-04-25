//
//  AppModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 25/04/2024.
//

import Foundation

class AppModel: ObservableObject {
    
    //MARK: - Properties
    @Published var walkModel = WalkModel()
}
