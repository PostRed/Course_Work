//
//  EntryView.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 10.03.2023.
//

import Foundation
import SwiftUI


struct AboutUsView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack (alignment: .leading) {
                    Text(" ЦЕХ - для тех, кто любит\n свой автомобиль")
                        .foregroundColor(getColor(color: Colors.customYellow))
                        .font(.system(size: 30, weight: .bold))
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ForEach(1..<9) {
                                Image("car\($0)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 250, height: 250)
                                    .cornerRadius(8)
                            }
                            .padding ()
                            .frame (height: 250)
                        }
                    }
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ForEach(1..<4) {
                                Image("rudder\($0)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 250, height: 250)
                                    .cornerRadius(8)
                            }
                            .padding ()
                            .frame (height: 250)
                        }
                    }
                    Text(" Профессиональные мастера\n Обслуживание премиум-класса,\n Качество превыше всего")
                        .foregroundColor(getColor(color: Colors.customYellow))
                        .font(.system(size: 20, weight: .bold))
                }
            }
            .background(getColor(color: Colors.customGrey))
        }
    }
}
