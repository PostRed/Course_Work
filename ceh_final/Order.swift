//
//  Order.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 28.04.2023.
//

import Foundation
import FirebaseFirestore

struct Order {
    
    var id: String = UUID().uuidString
    var type: String
    var description: String
    var date: Date
    var time: Date
    var connection: String
    var userId: String
    var status: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["type"] = self.type
        repres["description"] = self.description
        repres["date"] = self.date
        repres["time"] = self.time
        repres["connection"] = self.connection
        repres["userId"] = self.userId
        repres["status"] = self.status
        
        return repres
    }
    
    init(id: String = UUID().uuidString,
         type: String,
         description: String,
         date: Date,
         time: Date,
         connection: String,
         userId: String,
         status: String
    ) {
        self.id = id
        self.type = type
        self.description = description
        self.date = date
        self.time = time
        self.connection = connection
        self.userId = userId
        self.status = status
    }
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else {return nil}
        guard let type = data["type"] as? String else {return nil}
        guard let description = data["description"] as? String else {return nil}
        guard let date = data["date"] as? Timestamp else {return nil}
        guard let time = data["time"] as? Timestamp else {return nil}
        guard let connection = data["connection"] as? String else {return nil}
        guard let userId = data["userId"] as? String else {return nil}
        guard let status = data["status"] as? String else {return nil}
        
        self.id = id
        self.type = type
        self.description = description
        self.date = date.dateValue()
        self.time = time.dateValue()
        self.connection = connection
        self.userId = userId
        self.status = status
    }
}
