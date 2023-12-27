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
        HStack {
            VStack(alignment: .leading) {
                Text(restroom.name)
                    .font(.title)
                Text(restroom.address)
                Text(restroom.comment)
                    .font(.caption)
                AmenitiesTextView(restroom: restroom)
                    .padding(.top, 10)
            }
            .padding(.leading, 10)
            
            Spacer()
        }
    }
}

struct AmenitiesView: View {
    
    let restroom: Restroom
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                AmenitySymbolView(symbol: "figure.roll", isEnabled: restroom.accessible)
                AmenitySymbolView(symbol: "figure.dress.line.vertical.figure", isEnabled: restroom.unisex)
                AmenitySymbolView(symbol: "figure.child", isEnabled: restroom.changingTable)
            }
        }
    }
}

struct AmenitiesTextView: View {
    
    let restroom: Restroom
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 6) {
                AmenityTextView(text: "Accessible", isEnabled: restroom.accessible)
                AmenityTextView(text: "Unisex", isEnabled: restroom.unisex)
                AmenityTextView(text: "Changing Table", isEnabled: restroom.changingTable)
            }
        }
    }
}


struct AmenitySymbolView: View {
    
    let symbol: String
    let isEnabled: Bool
    
    var body: some View {
        if isEnabled {
            Image(systemName: symbol)
        }
        
    }
}

struct AmenityTextView: View {
    
    let text: String
    let isEnabled: Bool
    
    var body: some View {
        if isEnabled {
            HStack {
                Text(text)
                Image(systemName: "checkmark")
            }
            .background(Color.green)
        }
        
    }
}


#Preview {
    
    let restrooms: [Restroom] = PreviewData.load(resourceName: "restrooms")
    
    return RestroomDetailView(restroom: restrooms[4])
}
