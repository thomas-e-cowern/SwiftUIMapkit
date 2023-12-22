//
//  ActionButtons.swift
//  NearMe
//
//  Created by Thomas Cowern on 12/22/23.
//

import SwiftUI
import MapKit

struct ActionButtons: View {
    
    let mapItem: MKMapItem
    
    var body: some View {
        HStack {
            
            Button(action: {
                // Call
            }, label: {
                HStack {
                    Image(systemName: "phone.fill")
                    Text("Call")
                }
            })
            .buttonStyle(.bordered)
            .foregroundColor(.red)
            
            Button(action: {
                // Let's go
            }, label: {
                HStack {
                    Image(systemName: "car.circle.fill")
                    Text("Take me there")
                }
            })
            .buttonStyle(.bordered)
            .foregroundColor(.green)
        }
    }
}

#Preview {
    ActionButtons(mapItem: PreviewData.apple)
}
