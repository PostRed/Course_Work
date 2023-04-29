//
//  ContentView.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 10.03.2023.
//

import SwiftUI
import Firebase
 
struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var surname = ""
    @State private var patronymic = ""
    @State private var phone = ""
    @State public var userIsLoggedIn = false //!!!!!
    @State private var showingLogOutAlert = false
    @State public var is_login = true
    @State private var showingAlert = false
    @State private var error_text = ""
    @StateObject var viewModel = HomeViewModel(user: User(id: "", email: "", password: "", name: "", surname: "", patronymic: "", phone: 0))
    
    var body: some View {
        if userIsLoggedIn {
            main_page
        } else {
            login_page
        }
    }
    
    
    var main_page: some View {
        
        TabView {
            home_page
                .tabItem {
                    Label("ПРОФИЛЬ", systemImage: "person.circle")
                }
            EntryView()
                .tabItem {
                    Label("ПРИЁМ", systemImage: "square.and.pencil")
                }
            AboutUsView()
                .tabItem {
                    Label("О НАС", systemImage: "info.circle")
                }
            MapView()
                .tabItem {
                    Label("КАРТА", systemImage: "map")
                }
            SettingsView()
                .tabItem {
                    Label("НАСТРОЙКИ", systemImage: "gear")
                }
        }.accentColor(getColor(color: Colors.customYellow))
    }
    
    var login_page: some View {
        ZStack {
            getColor(color: Colors.customGrey)
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundColor(getColor(color: Colors.customYellow))
                .rotationEffect(.degrees(50))
            
            VStack() {
                Text("ЦЕХ")
                    .foregroundColor(getColor(color: Colors.customYellow))
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -130, y: is_login ? -200 : -107)
                Text(is_login ? "ВОЙДИТЕ В АККАУНТ" : "РЕГИСТРАЦИЯ")
                    .foregroundColor(getColor(color: Colors.customGrey))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
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
                
                if (!is_login) {
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
                }
                
                Button {
                    if (is_login) {
                        login_user()
                    } else {
                        register_user()
                    }
                } label: {
                    Text("ВОЙТИ")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(getColor(color: Colors.customGrey))
                        )
                        .foregroundColor(.white)
                }
                Button {
                    is_login.toggle()
                } label: {
                    Text(is_login ? "Зарегистрироваться" : "Назад")
                        .bold()
                        .foregroundColor(getColor(color: Colors.customGrey))
                }
                
            }
            
        }
        .alert(error_text, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        
        .ignoresSafeArea()
    }
    
    func login_user() {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            if let error = error {
                error_text = error.localizedDescription
                print(error.localizedDescription)
                showingAlert = true
            } else {
                userIsLoggedIn.toggle()
            }
        }
    }
    
    func register_user() {
        let  int_phone = Int(phone) ?? 0
        if (name.isEmpty || name.count > 50) {
            error_text = "Имя должно содержать от 1 до 50 символов"
            showingAlert = true
        } else if (surname.isEmpty || surname.count > 50) {
            error_text = "Фамилия должна содержать от 1 до 50 символов"
            showingAlert = true
        }
        else if (surname.isEmpty || surname.count > 50) {
            error_text = "Фамилия должна содержать от 1 до 50 символов"
            showingAlert = true
        }
        else if (int_phone == 0 || phone.count != 10) {
            error_text = "Телефон должен содержать 10 цифр"
            showingAlert = true
        }
        else {
            Auth.auth().createUser(withEmail: email,
                                   password: password) {
                result, error in
                if let result = result {
                    let user = User(
                        id: result.user.uid,
                        email: email,
                        password: password,
                        name: name,
                        surname: surname,
                        patronymic: patronymic,
                        phone: int_phone
                    )
                    DatabaseService.shared.setUser(user: user) {
                        resultDB in
                        switch resultDB {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case .success(_):
                            print()
                        }
                    }
                    userIsLoggedIn.toggle()
                    
                } else if let error = error {
                    error_text = error.localizedDescription
                    print(error.localizedDescription)
                    showingAlert = true
                }
            }
            
        }
    }
    
    var home_page: some View {
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
                TextField("ТЕЛЕФОН", value: $viewModel.user.phone, format: IntegerFormatStyle.number)
                    .foregroundColor(getColor(color: Colors.customYellow))
                TextField("ПОЧТА", text: $viewModel.user.email)
                    .foregroundColor(getColor(color: Colors.customYellow))
            }
            .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 220)
            .padding()
            if viewModel.orders.count != 0 {
                VStack {
                            ForEach(viewModel.orders, id: \.id) { order in
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
            
            Button {
                
                showingLogOutAlert.toggle()
            } label: {
                Text("ВЫЙТИ")
                    .foregroundColor(getColor(color: Colors.customGrey))
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(getColor(color: Colors.customYellow))
                    )
                    .foregroundColor(.white)
                
            }
            .offset(x:0, y:UIScreen.main.bounds.size.height/2 - 110)
            .confirmationDialog("Действительно хотите выйти?", isPresented: $showingLogOutAlert, titleVisibility: .visible) {
                Button{
                    userIsLoggedIn = false
                } label: {
                    Text("ДА")
                }
            }
            .onAppear {
                self.viewModel.getUser()
                self.viewModel.getOrders()
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func placeholder<Content: View> (
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content)
    -> some View {
        ZStack (alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
