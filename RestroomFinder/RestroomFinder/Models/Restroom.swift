//
//  Restroom.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/23/23.
//

import Foundation
import MapKit

struct Restroom: Decodable {
    let id: Int
    let name: String
    let street: String
    let city: String
    let state: String
    let country: String
    let accessible: Bool
    let unisex: Bool
    let directions: String
    let comment: String
    let changingTable: Bool
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey, Decodable {
        case id
        case name
        case street
        case city
        case state
        case country
        case accessible
        case unisex
        case directions
        case comment
        case changingTable = "changing_table"
        case latitude
        case longitude
    }
    
    var address: String {
        "\(street), \(city) \(state)"
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
