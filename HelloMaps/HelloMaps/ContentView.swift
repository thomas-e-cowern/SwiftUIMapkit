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
            Annotation("Coffee", coordinate: .coffee) {
                Image(systemName: "cup.and.saucer.fill")
                    .font(.largeTitle)
                    
            }
            
            Annotation("Geatano's", coordinate: .restaurant) {
                Image(systemName: "fork.knife.circle.fill")
                    .font(.largeTitle)
            }
        }
        
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
