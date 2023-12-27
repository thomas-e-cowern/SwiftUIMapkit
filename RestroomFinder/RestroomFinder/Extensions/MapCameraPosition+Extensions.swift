//
//  MapCameraPosition+Extensions.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/27/23.
//

import Foundation
import MapKit
import SwiftUI

extension MapCameraPosition {
    static var northHavenCT: MapCameraPosition {
        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.3909, longitude: -72.8595), latitudinalMeters: 100, longitudinalMeters: 100))
    }
}
