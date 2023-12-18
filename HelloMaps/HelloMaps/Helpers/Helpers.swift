//
//  Helpers.swift
//  HelloMaps
//
//  Created by Thomas Cowern on 12/18/23.
//

import Foundation
import MapKit
import SwiftUI

enum MapOptions: String, Identifiable, CaseIterable {
    
    case standard
    case hybrid
    case imagery
    
    var id: String {
        self.rawValue
    }
    
    var mapStyle: MapStyle {
        switch self {
        case .standard:
            return .standard
        case .hybrid:
            return .hybrid
        case .imagery:
            return .imagery
        }
    }
}
