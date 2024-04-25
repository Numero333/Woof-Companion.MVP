//
//  AuthDataResultModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation
import Firebase

struct AuthDataResultModel {
    
    //MARK: - Properties
    let uid: String
    let email: String?
    
    //MARK: - Initialization
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}
