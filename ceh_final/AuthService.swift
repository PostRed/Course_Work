//
//  AuthService.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 25.04.2023.
//

import Foundation
import Firebase

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    private let auth = Auth.auth()
    
    public var current_user: Firebase.User? {
        return auth.currentUser
    }
}
