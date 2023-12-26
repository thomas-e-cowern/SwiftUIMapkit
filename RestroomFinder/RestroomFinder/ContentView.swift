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
    
    var body: some View {
        ZStack {
            Map {
                ForEach(restrooms, id: \.id) { restroom in
                    Marker(restroom.name, coordinate: restroom.coordinate)
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
