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
    
    static func load<T: Decodable>(resourceName: String) -> T {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "json") else {
            fatalError("Resource \(resourceName) does not exist")
        }

        let data = try! Data(contentsOf: URL(filePath: path))
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
