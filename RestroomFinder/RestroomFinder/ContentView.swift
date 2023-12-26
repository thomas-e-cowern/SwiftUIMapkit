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
    
    var body: some View {
        ZStack {
            Map {
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
        .task(id: locationManager.region) {
            await loadRestrooms()
        }
    }
    
    private func loadRestrooms() async {
        
        guard let region = locationManager.region else { return }
        let coordinates = region.center
        
        do {
            restrooms = try await restroomClient.fetchRestrooms(url: Constants.Urls.restroomsByLocation(latitude: coordinates.latitude, longitude: coordinates.longitude))
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

#Preview {
    ContentView()
        .environment(\.httpClient, MockRestroomClient())
}
