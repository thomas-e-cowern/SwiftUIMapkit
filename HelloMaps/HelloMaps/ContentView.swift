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
    @State private var selectedMapOption: MapOptions = .standard
    
    // MARK: - Body
    var body: some View {
        ZStack (alignment: .top) {
            Map {
                Annotation("Coffee", coordinate: .coffee) {
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.largeTitle)
                        
                }
                
                Annotation("Geatano's", coordinate: .restaurant) {
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.largeTitle)
                }
            }
            .mapStyle(selectedMapOption.mapStyle)
            
            Picker("Map Style", selection: $selectedMapOption) {
                ForEach(MapOptions.allCases) { mapOption in
                    Text(mapOption.rawValue.capitalized).tag(mapOption)
                }
            }
            .pickerStyle(.segmented)
            .background(Color.white)
            .padding()
            
        } //: End of ZStack
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
