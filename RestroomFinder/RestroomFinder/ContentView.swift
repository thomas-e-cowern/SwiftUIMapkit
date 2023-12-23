//
//  ContentView.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.httpClient) private var restroomClient
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(\.httpClient, RestroomClient())
}
