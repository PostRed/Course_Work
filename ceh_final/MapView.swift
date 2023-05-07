//
//  EntryView.swift
//  ceh_final
//
//  Created by Анастасия Коломникова on 10.03.2023.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D( latitude: 55.752004, longitude: 37.617734),
        span: MKCoordinateSpan (latitudeDelta: 0.3,
                                longitudeDelta: 0.3))
    
    let mapLocations = [
            MapLocation(name: "Детейлинг, Москва, Перекопская 34к2", latitude:  55.662926, longitude: 37.565654),
            MapLocation(name: "Автосервис, Домодедово, Заречная 18", latitude:  55.264424, longitude: 37.848880)
            ]
    
    var body: some View {
        ZStack {
            Map(
               coordinateRegion: $region,
               interactionModes: MapInteractionModes.all,
               annotationItems: mapLocations,
               annotationContent: { location in
                   MapAnnotation(
                      coordinate: location.coordinate,
                      content: {
                          Image(systemName: "pin.circle.fill").foregroundColor(.red)
                          Text(location.name)
                              .padding()
                              .foregroundColor(.white)
                              .font(.system(size: 12, weight: .bold, design: .rounded))
                              .border(Color("yellow"),  width: 1)
                              .background(Color("grey_light"))
                      }
                   )
                  })
        }
    }
}
