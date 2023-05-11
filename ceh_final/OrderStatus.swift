//
//  OrderStatus.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 29.04.2023.
//

import Foundation

enum OrderStatus: String {
    case new = "Новый"
    case agreed = "Согласован"
    case progress = "В процессе"
    case comleted_warranty = " Выполнен, гарантия действует"
    case completed = "Выполнен, гарантийный срок истек"
}
