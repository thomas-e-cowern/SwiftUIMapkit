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
    @State private var selectedMapItem: MKMapItem?
    @State private var displayMode: DisplayMode = .list
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var route: MKRoute?
    @State private var showPreview: Bool = true
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Map(position: $position, selection: $selectedMapItem) {
                ForEach(mapItems, id: \.self) { mapItem in
                    Marker(item: mapItem)
                }
                
                if let route {
                    MapPolyline(route)
                        .stroke(Color.blue, lineWidth: 5)
                }
                
                UserAnnotation()
            }
            .onChange(of: locationManager.region, {
                position = .region(locationManager.region)
            })
            .sheet(isPresented: .constant(true), content: {
                VStack {
                    
                    switch displayMode {
                    case .list:
                        SearchBarView(search: $query, isSearching: $isSearching)
                        PlaceListView(mapItems: mapItems, selectedMapItem: $selectedMapItem)
                    case .detail:
                        SelectedPlaceDetailView(mapItem: $selectedMapItem)
                            .padding()
                        
                        if showPreview {
                            if selectedDetent == .medium || selectedDetent == .large {
                                if let selectedMapItem {
                                    ActionButtons(mapItem: selectedMapItem)
                                        .padding(.leading, 5)
                                }
                                LookAroundPreview(initialScene: lookAroundScene)
                                    .task(id: selectedMapItem) {
                                        if let scene = await getScene(selectedMapItem: selectedMapItem) {
                                            lookAroundScene = scene
                                        }
                                    }
                            }
                        } else {
                            EmptyView()
                        }
                    }
                }
                .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            })
        }
        .onChange(of: selectedMapItem, {
            if selectedMapItem != nil {
                displayMode = .detail
            } else {
                displayMode = .list
            }
        })
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
        .task(id: isSearching, {
            if isSearching {
                await search()
            }
        })
        .task(id: selectedMapItem) {
            route = nil
            if selectedMapItem != nil {
                await reqestCalculateDirections()
            }
        }
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
    
    func getScene(selectedMapItem: MKMapItem?) async -> MKLookAroundScene? {
        
        if let selectedMapItem {
            let request = MKLookAroundSceneRequest(mapItem: selectedMapItem)
            do {
                showPreview = true
                print("Show preview is \(showPreview)")
                return try await request.scene
//                return nil
            } catch {
                print("not available")
                showPreview = false
                print("Show preview is \(showPreview)")
                return nil
            }
        } else {
            return nil
        }
    }
    
    private func reqestCalculateDirections() async {
        route = nil
        if let selectedMapItem {
            guard let currentUserLocation = locationManager.manager.location else { return }
            let startingMapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentUserLocation.coordinate))
            
            self.route = await calculateDirections(from: startingMapItem, to: selectedMapItem)
            
        }
    }
}

// MARK: Display mode enum
enum DisplayMode {
    case list
    case detail
}

// MARK: - Preview
#Preview {
    ContentView()
}
