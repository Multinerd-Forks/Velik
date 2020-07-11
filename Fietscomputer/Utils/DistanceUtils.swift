//
//  DistanceUtils.swift
//  Fietscomputer
//
//  Created by Grigory Avdyushin on 10/07/2020.
//  Copyright © 2020 Grigory Avdyushin. All rights reserved.
//

import Foundation
import CoreLocation

enum DistanceUtils {

    static func step(for distance: CLLocationDistance, maxCount: Int? = nil) -> Measurement<UnitLength> {
        let meters = Measurement<UnitLength>(value: distance, unit: .meters)
        var step: Measurement<UnitLength>

        if meters.value / 1_000 > 1 {
            step = Measurement(value: 1, unit: .kilometers)
        } else if meters.value / 100 > 1 {
            step = Measurement(value: 100, unit: .meters)
        } else {
            step = Measurement(value: 10, unit: .meters)
        }

        if let maxCount = maxCount {
            var stepsCount = Int(meters.value / step.converted(to: .meters).value)
            var newStep = step
            var multiply = 1.0
            while stepsCount > maxCount {
                newStep.value = (5 * step.value * multiply)
                stepsCount = Int(meters.value / newStep.converted(to: .meters).value)
                multiply += 1
            }
            return newStep
        }

        return step
    }

    static var distanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter
    }()

    static func string(for distance: Measurement<UnitLength>) -> String {
        string(for: distance.value)
    }

    static func string(for distance: CLLocationDistance) -> String {
        Self.distanceFormatter.string(from: NSNumber(value: distance)) ?? ""
    }
}
