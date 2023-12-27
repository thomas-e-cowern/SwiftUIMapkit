//
//  RestroomDetailView.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/27/23.
//

import SwiftUI

struct RestroomDetailView: View {
    
    let restroom: Restroom
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(restroom.name)
                .font(.title)
            Text(restroom.address)
            Text(restroom.comment)
                .font(.caption)
            AmenitiesView(restroom: restroom)
        }
    }
}

struct AmenitiesView: View {
    
    let restroom: Restroom
    
    var body: some View {
        HStack(spacing: 12, content: {
            AmenityView(symbol: "figure.roll", isEnabled: restroom.accessible)
            AmenityView(symbol: "figure.dress.line.vertical.figure", isEnabled: restroom.unisex)
            AmenityView(symbol: "figure.child", isEnabled: restroom.changingTable)
        })
        .padding(.top, 10)
    }
}

struct AmenityView: View {
    
    let symbol: String
    let isEnabled: Bool
    
    var body: some View {
        if isEnabled {
            Image(systemName: symbol)
        }
            
    }
}

#Preview {
    
    let restrooms: [Restroom] = PreviewData.load(resourceName: "restrooms")
    
    return RestroomDetailView(restroom: restrooms[1])
}
