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
            Marker("Coffee", coordinate: .coffee)
            Marker("Gaetano's", coordinate: .restaurant)
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
