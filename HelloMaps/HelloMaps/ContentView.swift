//
//  ContentView.swift
//  HelloMaps
//
//  Created by Thomas Cowern on 12/18/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    // MARK: - Body
    var body: some View {
        Map {
            Marker(coordinate: <#T##CLLocationCoordinate2D#>, label: Text("Coffee"))
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
