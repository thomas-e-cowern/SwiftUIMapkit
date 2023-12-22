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
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Map(position: $position, selection: $selectedMapItem) {
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
                    
                    switch displayMode {
                    case .list:
                        SearchBarView(search: $query, isSearching: $isSearching)
                        PlaceListView(mapItems: mapItems, selectedMapItem: $selectedMapItem)
                    case .detail:
                        SelectedPlaceDetailView(mapItem: $selectedMapItem)
                            .padding()
                        LookAroundPreview(initialScene: lookAroundScene)
                            .task(id: selectedMapItem) {
                                let scene = await getScene(selectedMapItem: selectedMapItem)
                                lookAroundScene = scene
//                                lookAroundScene = nil
//                                if let selectedMapItem {
//                                    let request = MKLookAroundSceneRequest(mapItem: selectedMapItem)
//                                    do {
//                                        lookAroundScene = try? await request.scene
//                                        
//                                    } catch {
//                                        print("not available")
//                                    }
//                                    
//                                    
//                                }
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
                return try await request.scene
            } catch {
                print("not available")
                return nil
            }
        } else {
            return nil
        }
        
        //        if let latitude = tappedLocation?.latitude, let longitude = tappedLocation?.longitude {
        //            let sceneRequest = MKLookAroundSceneRequest(coordinate: .init(latitude: latitude, longitude: longitude))
        //
        //            do {
        //                return try await sceneRequest.scene
        //            } catch {
        //                return nil
        //            }
        //        } else {
        //            return nil
        //        }
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
