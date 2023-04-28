//
//  Order.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 28.04.2023.
//

import Foundation

struct Order {
    
    var id: String = UUID().uuidString
    var type: String
    var description: String
    var date: Date
    var connection: String
    var userId: String
    var status: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["type"] = self.type
        repres["description"] = self.description
        repres["date"] = self.date
        repres["connection"] = self.connection
        repres["userId"] = self.userId
        repres["status"] = self.status
        
        return repres
    }
}
