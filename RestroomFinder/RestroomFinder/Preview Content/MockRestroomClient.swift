//
//  MockRestroomClient.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/26/23.
//

import Foundation

struct MockRestroomClient: HTTPClient {
    
    func fetchRestrooms(url: URL) async throws -> [Restroom] {
        return []
    }

}
