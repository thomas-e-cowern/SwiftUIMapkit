//
//  ContentView.swift
//  HelloMaps
//
//  Created by Thomas Cowern on 12/18/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    // MARK: - Properties
    @State private var postion: MapCameraPosition = .userLocation(fallback: .automatic)
    @StateObject private var locationManager = LocationManager.shared
    @State private var selectedMapOption: MapOptions = .standard
    
    // MARK: - Body
    var body: some View {
        ZStack (alignment: .top) {
            Map(position: $postion) {
                Annotation("Coffee", coordinate: .coffee) {
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.largeTitle)
                        
                }
                
                Annotation("Geatano's", coordinate: .restaurant) {
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.largeTitle)
                }
                
                UserAnnotation()
            }
            .mapControls({
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            })
            .mapStyle(selectedMapOption.mapStyle)
            .onChange(of: locationManager.region) { oldValue, newValue in
                withAnimation {
                    postion = .region(locationManager.region)
                }
            }
            
//            Picker("Map Style", selection: $selectedMapOption) {
//                ForEach(MapOptions.allCases) { mapOption in
//                    Text(mapOption.rawValue.capitalized).tag(mapOption)
//                }
//            }
//            .pickerStyle(.segmented)
//            .background(Color.white)
//            .padding([.top], 60)
            
            VStack {
                Spacer()
                
                HStack {
                    Button("Coffee") {
                        withAnimation {
                            postion = .region(.coffee)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Restaurant") {
                        withAnimation {
                            postion = .region(.restuarant)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            
        } //: End of ZStack
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
