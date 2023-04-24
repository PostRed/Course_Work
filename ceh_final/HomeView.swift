//
//  Home.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 10.03.2023.
//

import Foundation
import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct HomeView: View {
    
    @State private var savedOffset = CGSize.zero
    @State private var dragValue = CGSize.zero
    @State private var name : String
    @State private var phone : String
    @State private var email : String
    
    init(name: String, phone: String, email: String){
        self.name = name
        self.phone = phone
        self.email = email
    }
    
    var body: some View {
        ZStack {
            getColor(color: Colors.customGrey)
            Text("ЦЕХ")
                .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 120)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(getColor(color: Colors.customYellow)!, lineWidth: 3)
                        .frame(width: 150, height: 40)
                        .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 120)
                    
                    
                )
                .fontWeight(.bold)
                .foregroundColor(getColor(color: Colors.customYellow))
            Text(name)
                .foregroundColor(getColor(color: Colors.customGrey))
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 150)
            
            Text(phone + "\t" + email)
                .foregroundColor(getColor(color: Colors.customGrey))
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 180)
            }
        
        }
}
