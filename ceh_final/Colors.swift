//
//  Colors.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 11.03.2023.
//

import Foundation
import SwiftUI

enum Colors {
    case customGrey
    case customYellow
    case backgroundYellow
    case lightCustomGrey
}

func getColor(color: Colors) -> Color? {
    switch color {
    case .customGrey:
        return Color(red: 48/255.0, green: 48/255.0, blue: 48/255.0)
    case .lightCustomGrey:
        return Color(red: 145/255.0, green: 145/255.0, blue: 145/255.0)
    case .customYellow:
        return Color(red: 252/255.0, green: 223/255.0, blue: 25/255.0)
    case .backgroundYellow:
        return Color(red: 252/255.0, green: 240/255.0, blue: 138/255.0)
    }
}
