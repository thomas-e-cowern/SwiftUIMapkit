//
//  PreviewData.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/23/23.
//

import Foundation
import MapKit
import Contacts

struct PreviewData {
    
    static var apple: MKMapItem {
        
        let coordinates = CLLocationCoordinate2D(latitude: 37.749, longitude: -122.4194)
        
        let addressDictionary: [String: Any] = [
            CNPostalAddressStreetKey: "1 Infinite Loop",
            CNPostalAddressCityKey: "Cupertino",
            CNPostalAddressStateKey: "California",
            CNPostalAddressPostalCodeKey: "95014"
        ]
        
        let phoneNumber = "1-555-555-1212"
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Apple, Inc"
        mapItem.phoneNumber = phoneNumber
        return mapItem
    }
}
