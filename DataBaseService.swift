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
    
    func getUser(comletion: @escaping (Result<User, Error>) -> ()) {
        usersRef.document(AuthService.shared.current_user!.uid).getDocument {
            docSnapshot, error in
            guard let snap = docSnapshot else {return}
            guard let data = snap.data() else {return}
            guard let userName = data["name"] as? String else {return}
            guard let userId = data["id"] as? String else {return}
            guard let userSurname = data["surname"] as? String else {return}
            guard let userPatronymic = data["patronymic"] as? String else {return}
            guard let userPassword = data["password"] as? String else {return}
            guard let userEmail = data["email"] as? String else {return}
            guard let userPhone = data["phone"] as? Int else {return}
            
            let user = User(id: userId, email: userEmail, password: userPassword, name: userName,
                            surname: userSurname, patronymic: userPatronymic, phone: userPhone)
            
            comletion(.success(user))
        }
    }
}

