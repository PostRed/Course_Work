//
//  OrderView.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 29.04.2023.
//

import Foundation
import SwiftUI

struct OrderView: View {
    
    @State var order: Order = Order(type: "Автосервис", description: "Сломалась машина", date: Date.now, connection: "", userId: "", status: "Новый")
    
    var body: some View {
        VStack {
            Text("Заказ в \(order.type)")
                .bold()
                .foregroundColor(.white)
            HStack {
                Text("\(order.description)")
                    .bold()
                    .foregroundColor(.white)
                Text("Статус: \(order.status)")
                    .bold()
                    .foregroundColor(.white)
            }.padding()
        }
        
        
    }
    
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
