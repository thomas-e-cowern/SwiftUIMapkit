//
//  ContentView.swift
//  NearMe
//
//  Created by Thomas Cowern on 12/20/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    // MARK: - Properties
    @State private var query: String = ""
    @State private var selectedDetent: PresentationDetent = .fraction(0.15)
    @State private var locationManager = LocationManager.shared
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Map(position: $position) {
                UserAnnotation()
            }
            .onChange(of: locationManager.region, {
                position = .region(locationManager.region)
            })
            .sheet(isPresented: .constant(true), content: {
                VStack {
                    TextField("Search", text: $query)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .onSubmit {
                            // Will initiate search
                        }
                }
                .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            })
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
