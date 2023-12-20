//
//  PlaceView.swift
//  NearMe
//
//  Created by Thomas Cowern on 12/20/23.
//

import SwiftUI
import MapKit

struct PlaceView: View {
    
    // MARK: - Properties
    let mapItem: MKMapItem
    
    private var address: String {
        let placemark = mapItem.placemark
        
        return "\(placemark.thoroughfare ?? "") \(placemark.subThoroughfare ?? "") \(placemark.locality ?? "") \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? "")"
    }
    
    // MARK: - Body
    var body: some View {
        VStack (alignment: .leading) {
            Text(mapItem.name ?? "")
                .font(.title3)
            Text(address)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        
    }
}

// MARK: - Preview
#Preview {
    PlaceView(mapItem: MKMapItem())
}
