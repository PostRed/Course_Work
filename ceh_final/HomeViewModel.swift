//
//  HomeViewModel.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 25.04.2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func setUser() {
        DatabaseService.shared.setUser(user: self.user)
        {
            result in
            switch result {
            case .success(let new_user):
                print(new_user.name)
            case .failure(let error):
                print("Ошибка сохранения данных")
                print(error.localizedDescription)
            }
       
        }
    }
    
    func getUser() {
        DatabaseService.shared.getUser
        {
            result in
            switch result {
            case .success(let new_user):
                self.user = new_user
            case .failure(let error):
                print(error.localizedDescription)
            }
       
        }
    }
    
}
