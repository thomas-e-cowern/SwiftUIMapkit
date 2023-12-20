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
    @State private var isSearching: Bool = false
    @State private var mapItems: [MKMapItem] = []
    
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
                            isSearching = true
                        }
                }
                .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            })
        }
        .task(id: isSearching, {
            if isSearching {
                await search()
            }
        })
    }
    
    // MARK: Methods and functions
    private func search() async {
        do {
            mapItems = try await performSearch(searchTerm: query, visibleRegion: locationManager.region)
            print(mapItems)
        } catch {
            mapItems = []
            print(error.localizedDescription)
            isSearching = false
        }
        
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
