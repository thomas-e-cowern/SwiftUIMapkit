//
//  Constants.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/26/23.
//

import Foundation

struct Constants {
    struct Urls {
        static func restroomsByLocation(latitude: Double, longitude: Double) -> URL {
            return URL(string: "https://www.refugerestrooms.org/api/v1/restrooms/by_location?lat=\(latitude)&long=\(longitude)")!
        }
    }
}
