//
//  MapUtilities.swift
//  NearMe
//
//  Created by Thomas Cowern on 12/20/23.
//

import Foundation
import MapKit

func performSearch(searchTerm: String, visibleRegion: MKCoordinateRegion?) async throws -> [MKMapItem] {
    
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = searchTerm
    request.resultTypes = .pointOfInterest
    
    guard let region = visibleRegion else { return [] }
    request.region = region
    
    let search = MKLocalSearch(request: request)
    let response = try await search.start()
    
    return response.mapItems
}

func calculateDistance(from: CLLocation, to: CLLocation) -> Measurement<UnitLength> {
    let distanceInMeters = from.distance(from: to)
    return Measurement(value: distanceInMeters, unit: .meters)
}

func calculateDirections(from: MKMapItem, to: MKMapItem) async -> MKRoute? {
    let directionRequest = MKDirections.Request()
    directionRequest.transportType = .automobile
    directionRequest.source = from
    directionRequest.destination = to
    
    let directions = MKDirections(request: directionRequest)
    let response = try? await directions.calculate()
    
    return response?.routes.first
}

func makePhoneCall(phoneNumber: String) {
    if let url = URL(string: "tel://\(phoneNumber)") {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Device can not make phone call")
        }
    }
}
