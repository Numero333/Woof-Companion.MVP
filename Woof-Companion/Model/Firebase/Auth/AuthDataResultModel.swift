//
//  AuthDataResultModel.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation
import Firebase

struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}
