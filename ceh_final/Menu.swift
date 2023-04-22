//
//  Menu.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 10.03.2023.
//

import Foundation
import SwiftUI

struct MenuItem {
    
}

enum MenuOptions: String, CaseIterable {
    case home = "ГЛАВНАЯ"
    case personalArea = "ЛИЧНЫЙ КАБИНЕТ"
    case entry = "ЗАПИСЬ"
    case aboutUs = "О НАС"
    case map = "КАРТА"
    case settings = "НАСТРОЙКИ"
    
    static func getItem(number: Int) -> String{
             
            switch number{
                 
                case 1:
                    return "ГЛАВНАЯ"
                case 2:
                    return "ЛИЧНЫЙ КАБИНЕТ"
                case 3:
                    return "ЗАПИСЬ"
                case 4:
                    return "О НАС"
                case 5:
                    return "КАРТА"
                case 6:
                    return "НАСТРОЙКИ"
                default:
                    return "undefined"
            }
    }
    
    static func showItem(number: Int) -> any View {
             
            switch number{
                 
                case 1:
                return Text("ГЛАВНАЯ")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar { // <2>
                            ToolbarItem(placement: .principal) { // <3>
                                VStack {
                                    Text("Title").font(.headline)
                                    Text("Subtitle").font(.subheadline)
                                }
                            }
                        }
                case 2:
                    return Text("")
                case 3:
                    return Text("")
                case 4:
                    return Text("")
                case 5:
                    return Text("")
                case 6:
                    return Text("")
                default:
                    return Text("")
            }
    }

}
