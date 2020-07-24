//
//  Settings.swift
//  Velik
//
//  Created by Grigory Avdyushin on 24/07/2020.
//  Copyright © 2020 Grigory Avdyushin. All rights reserved.
//

import Foundation

struct Settings {

    static let shared = Settings()

    var speedUnit: UnitSpeed {
        Locale.current.usesMetricSystem ? .kilometersPerHour : .milesPerHour
    }

    var distanceUnit: UnitLength {
        Locale.current.usesMetricSystem ? .kilometers : .miles
    }

    var smallDistanceUnit: UnitLength {
        Locale.current.usesMetricSystem ? .meters : .feet
    }

    var elevationUnit: UnitLength {
        .meters
    }

    var oneK: Double {
        let oneK = Measurement(value: 1_000, unit: UnitLength.meters)
        return oneK.converted(to: distanceUnit).value
    }
}
