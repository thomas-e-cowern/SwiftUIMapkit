//
//  ContentView.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/23/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @Environment(\.httpClient) private var restroomClient
    @State private var locationManager = LocationManager.shared
    @State private var restrooms: [Restroom] = []
    @State private var selectedRestroom: Restroom?
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(restrooms, id: \.id) { restroom in
                    Annotation(restroom.name, coordinate: restroom.coordinate) {
                        ZStack {
                            Circle()
                                .fill(.blue)
                                .frame(width: 45)
                            Text("🚽")
                                .font(.largeTitle)
                        }
                        .scaleEffect(selectedRestroom == restroom ? 1.5 : 1.0)
                        .onTapGesture {
                            withAnimation {
                                selectedRestroom = restroom
                            }
                        }
                        .animation(.spring(duration: 0.25), value: selectedRestroom)
                    }
                }
                
                UserAnnotation()
            }
        }
        .task(id: visibleRegion) {
            await loadRestrooms()
        }
        .onMapCameraChange({ context in
            visibleRegion = context.region
        })
        .overlay(alignment: .topLeading) {
            Button {
                Task {
                    await loadRestrooms()
                }
            } label: {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white, .blue)
            }
            .padding(.leading, 10)
        }
    }
    
    private func loadRestrooms() async {
        
        guard let region = visibleRegion else { return }
        let coordinates = region.center
        print("Coords: \(coordinates)")
        do {
            restrooms = try await restroomClient.fetchRestrooms(url: Constants.Urls.restroomsByLocation(latitude: coordinates.latitude, longitude: coordinates.longitude))
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
        .environment(\.httpClient, RestroomClient())
}
