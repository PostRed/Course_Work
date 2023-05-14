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
                    Color("grey").edgesIgnoringSafeArea(.all)
                    Text(" ЦЕХ - для тех, кто любит\n свой автомобиль")
                        .foregroundColor(Color("yellow"))
                        .font(.system(size: 30, weight: .bold, design: .rounded))
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
                    } .background(Color("grey"))
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
                    } .background(Color("grey"))
                    Text("Детейлинг, Москва, Перекопская 34к2\nАвтосервис, Домодедово, Заречная 18")
                        .foregroundColor(Color("yellow"))
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    HStack {
                        Text("Свяжитесь с нами: ")
                            .foregroundColor(Color("yellow"))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        Link(destination: URL(string: "https://t.me/+79091670815")!) {
                            Image(systemName: "paperplane.fill")
                                .font(.largeTitle)
                        }
                        Link(destination: URL(string: "https://wa.me/79091670815")!) {
                            Image(systemName: "phone.circle")
                                .font(.largeTitle)
                        }
                        Link(destination: URL(string: "https://yandex.ru/maps/org/tsekh_broni_i_keramiki/208551926594/?ll=37.563578%2C55.664121&z=18.16")!) {
                            Image(systemName: "y.circle.fill")
                                .font(.largeTitle)
                        }
                       
                    }
                   
                }
                .background(Color("grey"))
               
            }
        }.background(Color("grey"))
    }
}
