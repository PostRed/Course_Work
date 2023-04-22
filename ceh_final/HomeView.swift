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
    @State var name: String
    @State var surname: String
    @State var email: String
    
    init(name: String, surname: String, email: String){
            self.name = name
            self.surname = surname
            self.email = email
        }

    var body: some View {
        ZStack {
           // getColor(color: Colors.customGrey)
            //.ignoresSafeArea()
            Text("ЦЕХ")
                .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 90)
                .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(getColor(color: Colors.customYellow)!, lineWidth: 3)
                            .frame(width: 150, height: 40)
                            .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 90)
                           
                        
                    )
                   .fontWeight(.bold)
                   .foregroundColor(getColor(color: Colors.customYellow))
            Text("Коломникова")
                .foregroundColor(getColor(color: Colors.customGrey))
                .font(.system(size: 20, weight: .bold, design: .rounded))
            }
        
        }
}
