//
//  RestroomClient.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/23/23.
//

import Foundation

struct RestroomClient {
    
    private enum RestroomClientError: Error {
        case invalidResponse
        case networkError(Error)
    }
    
    func fetchRestrooms(url: URL) async throws -> [Restroom] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Yeah the error is here...")
            throw RestroomClientError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode([Restroom].self, from: data)
        } catch {
            throw RestroomClientError.networkError(error)
        }
    }
}
