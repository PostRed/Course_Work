//
//  EntryView.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 10.03.2023.
//

import Foundation
import SwiftUI

struct EntryView: View {
    
    var types = ["Автосервис", "Детейлинг  "]
    var connection = ["Позвонить", "Telegram   ", "WhatsApp ", " Email        "]
    @State private var selectedType = "Детейлинг  "
    @State private var selectedConnection = "Позвонить"
    @State private var date = Date.now
    @State private var description = ""
    
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
            VStack() {
                Text("ЗАПИШИТЕСЬ НА ПРИЁМ")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .bold()
                    .foregroundColor(getColor(color: Colors.customYellow))
                
                    Text("Выберите тип сервиса:")
                    .bold()
                        //.offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 220)
                    .foregroundColor(getColor(color: Colors.customYellow))
                        .padding()
                    Picker("Выберите тип сервиса:", selection: $selectedType) {
                        ForEach(types, id: \.self) {
                            Text($0)
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .foregroundColor(getColor(color: Colors.customYellow))
                        }
                    }
                    .foregroundColor(getColor(color: Colors.customYellow))
                    .clipped()
                    .foregroundColor(getColor(color: Colors.customYellow))
                   // .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 255)
                .padding()
                
                HStack() {
                    Text("Выберите дату:")
                        .bold()
                        .foregroundColor(getColor(color: Colors.customYellow))
                     //   .offset(x:20, y:-UIScreen.main.bounds.size.height/2 + 300)
                    DatePicker(selection: $date, in: Date.now..., displayedComponents: .date) {
                                    
                                }
                    .clipped()
                    .labelsHidden()
                    .colorInvert()
                    .colorMultiply(getColor(color: Colors.customYellow) ?? .yellow)
                       
                    .accentColor(getColor(color: Colors.customYellow))
                   // .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 300)
                    
                }
                .padding()
               
                
                Text("Опишите запрос:")
                   // .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 350)
                    .bold()
                    .foregroundColor(getColor(color: Colors.customYellow))
                TextField("Запрос", text: $description)
                    .textFieldStyle(MyTextFieldStyle())
                    //.offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 420)
                    .foregroundColor(.white)
                
                HStack() {
                    Text("Как с Вами связаться:")
                        .bold()
                        .foregroundColor(getColor(color: Colors.customYellow))
                    //    .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 500)
                        .padding()
                    Picker("Как с Вами связаться:", selection: $selectedConnection) {
                        ForEach(connection, id: \.self) {
                            Text($0)
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .foregroundColor(getColor(color: Colors.customGrey))
                        }
                    }
                    .accentColor(getColor(color: Colors.customYellow))
                    .clipped()
                    .foregroundColor(getColor(color: Colors.customYellow))
                   // .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 500)
                }
                .padding()
                Button {
                    print("entry")
                } label: {
                    Text("ЗАПИСАТЬСЯ")
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
    }

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(getColor(color: Colors.customYellow) ?? .yellow, lineWidth: 3)
        ).padding()
    }
}
