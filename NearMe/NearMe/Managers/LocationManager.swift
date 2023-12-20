//
//  LocationManager.swift
//  NearMe
//
//  Created by Thomas Cowern on 12/20/23.
//

import Foundation
import MapKit
import Observation

enum LocationError: LocalizedError {
    case authorizationDenied
    case authorizationRestricted
    case unknownLocation
    case accessDenied
    case network
    case operationFailed
    
    var errorDescription: String? {
        switch self {
        case .authorizationDenied:
            return NSLocalizedString("Location access is denied", comment: "")
        case .authorizationRestricted:
            return NSLocalizedString("Location access is restricted", comment: "")
        case .unknownLocation:
            return NSLocalizedString("This is an unknown location", comment: "")
        case .accessDenied:
            return NSLocalizedString("Access is denied", comment: "")
        case .network:
            return NSLocalizedString("The network failed", comment: "")
        case .operationFailed:
            return NSLocalizedString("The operation had failed", comment: "")
        }
    }
}

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    static let shared = LocationManager()
    
    var region: MKCoordinateRegion = MKCoordinateRegion()
    
    private override init() {
        super.init()
        self.manager.delegate = self
    }
}

extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied:
            print("Denied")
        case .restricted:
            print("Restricted")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
