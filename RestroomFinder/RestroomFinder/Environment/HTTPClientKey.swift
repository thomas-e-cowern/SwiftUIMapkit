//
//  HTTPClientKey.swift
//  RestroomFinder
//
//  Created by Thomas Cowern on 12/23/23.
//

import Foundation
import SwiftUI

private struct HTTPClientKey: EnvironmentKey {
    static var defaultValue = RestroomClient()
}

extension EnvironmentValues {
    var httpClient: RestroomClient {
        get { self[HTTPClientKey.self] }
        set { self[HTTPClientKey.self] = newValue }
    }
}
