//
//  EntryView.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 10.03.2023.
//

import Foundation
import SwiftUI


struct SettingsView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var surname = ""
    @State private var patronymic = ""
    @State private var phone = ""
    @State private var sales_notice = true
    @State private var service_notice = true
    @State private var orders_notice = true
  
    var body: some View {
        ZStack {
            getColor(color: Colors.customGrey)
               
           // getColor(color: Colors.customGrey)
            //.ignoresSafeArea()
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
            VStack (spacing: 20) {
                TextField("ПОЧТА", text: $email)
                    .foregroundColor(getColor(color: Colors.customGrey))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: email.isEmpty) {
                        Text("ПОЧТА")
                            .foregroundColor(.white)
                            .bold()
                    }
                SecureField("ПАРОЛЬ", text: $password)
                    .foregroundColor(getColor(color: Colors.customGrey))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: password.isEmpty) {
                        Text("ПАРОЛЬ")
                            .foregroundColor(.white)
                            .bold()
                    }
                TextField("ИМЯ", text: $name)
                    .foregroundColor(getColor(color: Colors.customGrey))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: name.isEmpty) {
                        Text("ИМЯ")
                            .foregroundColor(.white)
                            .bold()
                    }
                TextField("ФАМИЛИЯ", text: $surname)
                    .foregroundColor(getColor(color: Colors.customGrey))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: surname.isEmpty) {
                        Text("ФАМИЛИЯ")
                            .foregroundColor(.white)
                            .bold()
                    }
                TextField("ОТЧЕСТВО", text: $patronymic)
                    .foregroundColor(getColor(color: Colors.customGrey))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: patronymic.isEmpty) {
                        Text("ОТЧЕСТВО")
                            .foregroundColor(.white)
                            .bold()
                    }
                TextField("+7 ТЕЛЕФОН", text: $phone)
                    .foregroundColor(getColor(color: Colors.customGrey))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: phone.isEmpty) {
                        Text("+7 ТЕЛЕФОН")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Toggle("Оповещать об изменениях статусов заказа", isOn: $orders_notice)
                    .bold()
                    .toggleStyle(SwitchToggleStyle(tint: getColor(color: Colors.customYellow) ?? .yellow))
                    .foregroundColor(getColor(color: Colors.customYellow))
                Toggle("Напоминать о плановом ТО", isOn: $service_notice)
                    .bold()
                    .toggleStyle(SwitchToggleStyle(tint: getColor(color: Colors.customYellow) ?? .yellow))
                    .foregroundColor(getColor(color: Colors.customYellow))

                Toggle("Оповещать о новых акциях и предложениях", isOn: $sales_notice)
                    .bold()
                    .toggleStyle(SwitchToggleStyle(tint: getColor(color: Colors.customYellow) ?? .yellow))
                    .foregroundColor(getColor(color: Colors.customYellow))


                        
                
                // Собачки для смены темы и настройки оповещений 1 акции, 2 плановые ТО, 3 изменения статусов заказов
                
                Button {
                    save_changes()
                } label: {
                    Text("СОХРАНИТЬ")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(getColor(color: Colors.customYellow))
                        )
                        .foregroundColor(getColor(color: Colors.customGrey))
                }
            }

            
            }
    }
    
    func save_changes() {
        
    }
    
    
}
