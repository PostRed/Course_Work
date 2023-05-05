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
    @State private var showEntryMessage = false
    @State private var messageText = ""

    
    var body: some View {
        ZStack {
            Image("back_car")
                .resizable()
                .aspectRatio(UIImage(named: "back_car")!.size, contentMode: .fill)
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
                HStack {
                    Text("Выберите тип сервиса:")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(alignment: .topLeading)
                    .padding()
                   
                
                    Picker("Выберите тип сервиса:", selection: $selectedType) {
                        ForEach(types, id: \.self) {
                            Text($0)
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .foregroundColor(getColor(color: Colors.customYellow))
                        }
                    }
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .clipped()
                }
                .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                .border(getColor(color: Colors.customYellow) ?? .yellow,  width: 3)
                .background(Color("grey_light"))
                    
                
                HStack(spacing: 80) {
                    Text("Выберите дату:")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    DatePicker(selection: $date, in: Date.now..., displayedComponents: .date) {
                    }
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .clipped()
                    .labelsHidden()
                    .colorInvert()
                    .colorMultiply(getColor(color: Colors.customYellow) ?? .yellow)
                    .accentColor(getColor(color: Colors.customYellow))
                    
                }
                .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                .border(getColor(color: Colors.customYellow) ?? .yellow,  width: 3)
                .background(Color("grey_light"))
                .padding()
               
                
                Text("ОПИШИТЕ ЗАПРОС:")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .bold()
                    .foregroundColor(getColor(color: Colors.customYellow))
                
                TextField("Запрос", text: $description)
                    .frame(alignment: .topLeading)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                    .border(getColor(color: Colors.customYellow) ?? .yellow,  width: 3)
                    .background(Color("grey_light"))
                    .padding()
                   
                
                HStack(spacing: 35) {
                    Text("Как с Вами связаться:")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
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
                }
                .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                .border(getColor(color: Colors.customYellow) ?? .yellow,  width: 3)
                .background(Color("grey_light"))
                .padding()
                
                Button {
                    let order = Order(type: selectedType, description: description, date: date, connection: selectedConnection, userId: AuthService.shared.current_user!.uid, status: OrderStatus.new.rawValue)
                    
                    DatabaseService.shared.setOrder(order: order) {
                        resultDB in
                        switch resultDB {
                        case .failure(let error):
                            showEntryMessage = true
                            messageText = "Не удалось создать заказ, попробуйте позже"
                            print(error.localizedDescription)
                        case .success(_):
                            showEntryMessage = true
                            messageText = "Заказ успешно создан"
                            description = ""
                        }
                    }
                    
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
        .alert(messageText, isPresented: $showEntryMessage) {
            Button("OK", role: .cancel) { }
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
