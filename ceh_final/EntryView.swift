//
//  EntryView.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 10.03.2023.
//

import Foundation
import SwiftUI

struct EntryView: View {
    
    var body: some View {
        ZStack {
           // getColor(color: Colors.customGrey)
            //.ignoresSafeArea()
            Text("ЦЕХ")
                .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 90)
                .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(getColor(color: Colors.customYellow)!, lineWidth: 3)
                            .frame(width: 150, height: 40)
                            .offset(x:0, y:-UIScreen.main.bounds.size.height/2 + 90)
                           
                        
                    )
                   .fontWeight(.bold)
                   .foregroundColor(getColor(color: Colors.customYellow))
            }
    }
}
