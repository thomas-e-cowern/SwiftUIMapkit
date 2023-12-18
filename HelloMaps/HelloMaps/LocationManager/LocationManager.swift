//
//  LocationManager.swift
//  HelloMaps
//
//  Created by Thomas Cowern on 12/18/23.
//

import Foundation
import MapKit

@MainActor
class LocationManager {
    static let shared = LocationManager()
    let manager: CLLocationManager
    
    init() {
        self.manager = CLLocationManager()
        if self.manager.authorizationStatus == .notDetermined {
            self.manager.requestWhenInUseAuthorization()
        }
    }
}
