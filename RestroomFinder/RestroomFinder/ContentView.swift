//
//  ContentView.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.httpClient) private var restroomClient
    @State private var locationManager = LocationManager.shared
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    func loadRestrooms() async {
        guard let region =  locationManager.region else { return }
        let coordinates = region.center
        
        restroomClient
    }
}

#Preview {
    ContentView()
        .environment(\.httpClient, RestroomClient())
}
