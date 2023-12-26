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
    
    private var distance: Measurement<UnitLength>? {
        guard let userLocation = LocationManager.shared.manager.location, let destinationLocation = mapItem.placemark.location else {
            return nil
        }
        
        return calculateDistance(from: userLocation, to: destinationLocation)
    }
    
    // MARK: - Body
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading) {
                Text("Name")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                Text(mapItem.name ?? "")
                    .font(.title3)
            }

            
            VStack (alignment: .leading) {
                Text("Address")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                Text(address)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                if let phone = mapItem.phoneNumber {
                    VStack (alignment: .leading) {
                    Text("Phone")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    Text(phone)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }

            
            if let distance {
                VStack (alignment: .leading) {
                    Text("Distance")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    Text(distance, formatter: MeasurementFormatter.distance)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
        .padding()
        .clipShape(.rect)
    }
}

// MARK: - Preview
#Preview {
    PlaceView(mapItem: PreviewData.apple)
}
