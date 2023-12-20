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
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Map()
                .sheet(isPresented: .constant(true), content: {
                    VStack {
                        TextField("Search", text: $query)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                            .onSubmit {
                                // Will initial search
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
