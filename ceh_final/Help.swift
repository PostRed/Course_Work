//
//  Help.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 02.05.2023.
//

import Foundation
import SwiftUI

struct help {
    
    @State private var showScroll: Bool = true
    
       var body: some View {
           VStack {
               Spacer()
               Button(action: {
                   withAnimation {
                       self.showScroll = true
                   }
               }, label: {
                   Text("Hit me")
               }).padding()
                   .background(Capsule().fill())
               Spacer()
               if showScroll {
                   scrollView
               }
           }
       }
       
       
       var scrollView: some View {
           ScrollView(.horizontal, showsIndicators: false) {
               HStack {
                   Text("Horizontal list")
                   Text("Horizontal list")
                   Text("Horizontal list")
                   Text("Horizontal list")
               }
               .frame(minHeight: 0, maxHeight: .greatestFiniteMagnitude)
           }
           .frame(height: 100)
           .transition(.move(edge: .bottom))
       }
}
