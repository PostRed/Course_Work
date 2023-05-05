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
}

func getColor(color: Colors) -> Color? {
    switch color {
    case .customGrey:
        return Color(red: 48/255.0, green: 48/255.0, blue: 48/255.0)
    case .customYellow:
        return Color(red: 252/255.0, green: 223/255.0, blue: 25/255.0)
    }
}
