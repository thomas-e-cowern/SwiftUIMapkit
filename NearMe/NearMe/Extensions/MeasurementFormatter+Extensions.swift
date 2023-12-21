//
//  MeasurementFormatter+Extensions.swift
//  NearMe
//
//  Created by Thomas Cowern on 12/21/23.
//

import Foundation

extension MeasurementFormatter {
    static var distance: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .naturalScale
        formatter.locale = Locale.current
        
        return formatter
    }
}
