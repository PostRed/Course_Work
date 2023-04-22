//
//  DataBaseService.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 18.04.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private init(){}
    
    func setUser(user: User, comletion: @escaping (Result<User, Error>) -> ()) {
        usersRef.document(user.id).setData(
            user.representation
        ) {error in
            if let error = error {
                comletion(.failure(error))
            } else {
                comletion(.success(user))
            }
        }
        
    }
}

