//
//  ContentView.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 10.03.2023.
//

import SwiftUI
import Firebase
 
struct ContentView: View {
    
    @State private var sales_notice = true
    @State private var service_notice = true
    @State private var orders_notice = true
    
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var surname = ""
    @State private var patronymic = ""
    @State private var phone = ""
    @State private var new_phone = ""
    @State public var userIsLoggedIn = false //!!!!!
    @State private var showingLogOutAlert = false
    @State public var is_login = true
    @State private var showingAlert = false
    @State private var error_text = ""
    @State private var settings_text = ""
    @State private var show_settings_message = false
    @StateObject var viewModel = HomeViewModel(user: User(id: "", email: "", password: "", name: "", surname: "", patronymic: "", phone: ""))
    
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
                    Label("ЗАПИСЬ", systemImage: "square.and.pencil")
                }
            AboutUsView()
                .tabItem {
                    Label("О НАС", systemImage: "info.circle")
                }
            MapView()
                .tabItem {
                    Label("КАРТА", systemImage: "map")
                }
            settings_page
                .tabItem {
                    Label("НАСТРОЙКИ", systemImage: "gear")
                }
        }
        .accentColor(Color("yellow"))
    }
    
    var login_page: some View {
        ZStack {
            Color("grey")
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundColor(Color("yellow"))
                .rotationEffect(.degrees(50))
            
            VStack() {
                Text("ЦЕХ")
                    .foregroundColor(Color("yellow"))
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -130, y: is_login ? -200 : -107)
                Text(is_login ? "ВОЙДИТЕ В АККАУНТ" : "РЕГИСТРАЦИЯ")
                    .foregroundColor( Color("grey"))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                TextField("ПОЧТА", text: $email)
                    .foregroundColor( Color("grey"))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: email.isEmpty) {
                        Text("ПОЧТА")
                            .foregroundColor(.white)
                            .bold()
                    }
                SecureField("ПАРОЛЬ", text: $password)
                    .foregroundColor(Color("grey"))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: password.isEmpty) {
                        Text("ПАРОЛЬ")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                if (!is_login) {
                    TextField("ИМЯ", text: $name)
                        .foregroundColor(Color("grey"))
                        .textFieldStyle(.roundedBorder)
                        .placeholder(when: name.isEmpty) {
                            Text("ИМЯ")
                                .foregroundColor(.white)
                                .bold()
                        }
                    TextField("ФАМИЛИЯ", text: $surname)
                        .foregroundColor(Color("grey"))
                        .textFieldStyle(.roundedBorder)
                        .placeholder(when: surname.isEmpty) {
                            Text("ФАМИЛИЯ")
                                .foregroundColor(.white)
                                .bold()
                        }
                    TextField("ОТЧЕСТВО", text: $patronymic)
                        .foregroundColor(Color("grey"))
                        .textFieldStyle(.roundedBorder)
                        .placeholder(when: patronymic.isEmpty) {
                            Text("ОТЧЕСТВО")
                                .foregroundColor(.white)
                                .bold()
                        }
                    TextField("+7 ТЕЛЕФОН", text: $phone)
                        .foregroundColor(Color("grey"))
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
                                .foregroundColor(Color("grey"))
                        )
                        .foregroundColor(.white)
                }
                Button {
                    is_login.toggle()
                } label: {
                    Text(is_login ? "Зарегистрироваться" : "Назад")
                        .bold()
                        .foregroundColor(Color("grey"))
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
        else if !isValidEmail(email) {
            error_text = "Некорректный адрес электронной почты"
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
                        phone: phone
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

    
    var settings_page: some View {
        ZStack {
            Image("back_car")
                .resizable()
                .aspectRatio(UIImage(named: "back_car")!.size, contentMode: .fill)
            Text("ЦЕХ")
                .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 120)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 120)
                        .stroke(Color("yellow"), lineWidth: 3)
                        .frame(width: 150, height: 40)
                )
                .fontWeight(.bold)
                .foregroundColor(Color("yellow"))
            
            VStack () {
               
                TextField("ПОЧТА", text: $viewModel.user.email)
                    .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                    .foregroundColor(Color("grey"))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: email.isEmpty) {
                        Text("ПОЧТА")
                            .foregroundColor(.white)
                            .bold()
                    }
                SecureField("ПАРОЛЬ", text: $viewModel.user.password)
                    .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                    .foregroundColor(Color("grey"))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: password.isEmpty) {
                        Text("ПАРОЛЬ")
                            .foregroundColor(.white)
                            .bold()
                    }
                TextField("ИМЯ", text: $viewModel.user.name)
                    .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                    .foregroundColor(Color("grey"))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: name.isEmpty) {
                        Text("ИМЯ")
                            .foregroundColor(.white)
                            .bold()
                    }
                TextField("ФАМИЛИЯ", text: $viewModel.user.surname)
                    .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                    .foregroundColor(Color("grey"))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: surname.isEmpty) {
                        Text("ФАМИЛИЯ")
                            .foregroundColor(.white)
                            .bold()
                    }
                TextField("ОТЧЕСТВО", text: $viewModel.user.patronymic)
                    .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                    .foregroundColor(Color("grey"))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: patronymic.isEmpty) {
                        Text("ОТЧЕСТВО")
                            .foregroundColor(.white)
                            .bold()
                    }
                TextField("+7 ТЕЛЕФОН", text: $viewModel.user.phone)
                    .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                    .foregroundColor(Color("grey"))
                    .textFieldStyle(.roundedBorder)
                    .placeholder(when: phone.isEmpty) {
                        Text("+7 ТЕЛЕФОН")
                            .foregroundColor(.white)
                            .bold()
                    }

                
               
                
            }
            
            Button {
                save_changes()
            } label: {
                Text("СОХРАНИТЬ")
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(Color("yellow"))
                    )
                    .foregroundColor(Color("grey"))
            }
            .padding()
            .alert(settings_text, isPresented: $show_settings_message) {
                Button("OK", role: .cancel) { }
            }
            .offset(x:0, y:UIScreen.main.bounds.size.height/2 - 110)
        }
        
    }
    func save_changes() {
        if isValidPhoneNumber(phone) && isValidEmail(email) {
            viewModel.setUser()
            show_settings_message = true
            settings_text = "Изменения успешно сохранены"
        } else {
            show_settings_message = true
            settings_text = "Пожалуйста, введите корректный номер телефона и адрес электронной почты"
        }
    }

    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^[0-9]{10}$" 
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phoneNumber)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

        
        var home_page: some View {
            ZStack {
                Image("back_car")
                    .resizable()
                    .aspectRatio(UIImage(named: "back_car")!.size, contentMode: .fill)
                Text("ЦЕХ")
                    .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 120)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 120)
                            .stroke(Color("yellow"), lineWidth: 3)
                            .frame(width: 150, height: 40)
                    )
                    .fontWeight(.bold)
                    .foregroundColor(Color("yellow"))
                Text(self.viewModel.user.name)
                    .foregroundColor(Color("yellow"))
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 180)
                    .padding()
                
                Text("+7 \(viewModel.user.phone)\t\(viewModel.user.email)")
                    .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 220)
                    .foregroundColor(Color("yellow"))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding()
                VStack {
                    ForEach(viewModel.orders, id: \.id) { order in
                        Text(" Заказ в \(order.type)\t\(order.date.formatted(.dateTime.day().month(.twoDigits))) | \(order.time.formatted(.dateTime.hour().minute()))\n \(order.description)\n Статус: \(order.status)")
                            .padding()
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width:  UIScreen.main.bounds.size.width, alignment: .topLeading)
                            .border(Color("yellow"),  width: 3)
                            .background(Color("grey_light"))
                    }
                    
                   
                }
                Button {
                    showingLogOutAlert.toggle()
                } label: {
                    Text("ВЫЙТИ")
                        .foregroundColor(Color("grey"))
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(Color("yellow"))
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
                
            }
            .onAppear {
                self.viewModel.getUser()
                self.viewModel.getOrders()
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
