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
    
    @StateObject var viewModel = HomeViewModel(user: User(id: "", email: "Email", password: "", name: "Name", surname: "", patronymic: "", phone: ""))
    
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
            Text(self.viewModel.user.name)
                .foregroundColor(getColor(color: Colors.customYellow))
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 180)
                .padding()
            
            HStack {
                Text("+7")
                    .foregroundColor(getColor(color: Colors.customYellow))
                TextField("ТЕЛЕФОН", text: $viewModel.user.phone)
                    .foregroundColor(getColor(color: Colors.customYellow))
                TextField("ПОЧТА", text: $viewModel.user.email)
                    .foregroundColor(getColor(color: Colors.customYellow))
            }
            .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 220)
            .padding()
            Button {
                print("выход")
                
            } label: {
                Text("ВЫЙТИ")
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(getColor(color: Colors.customGrey))
                    )
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            self.viewModel.getUser()
        }
        
    }
}
