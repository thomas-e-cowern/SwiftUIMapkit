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
    @State private var visibleRegion: MKCoordinateRegion?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(mapItems, id: \.self) { mapItem in
                    Marker(item: mapItem)
                }
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
                    
                    List(mapItems, id: \.self) { mapItem in
                        Text(mapItem.name ?? "")
                        Text(mapItem.phoneNumber ?? "")
                    }
                }
                .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            })
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
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
            
            mapItems = try await performSearch(searchTerm: query, visibleRegion: visibleRegion)
            isSearching = false
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
