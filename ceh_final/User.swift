//
//  User.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 18.04.2023.
//

import Foundation

struct User: Identifiable {
    var id: String
    var email: String
    var password: String
    var name: String
    var surname: String
    var patronymic: String
    var phone: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["email"] = self.email
        repres["password"] = self.password
        repres["name"] = self.name
        repres["surname"] = self.surname
        repres["patronymic"] = self.patronymic
        repres["phone"] = self.phone
        
        return repres
    }
}
