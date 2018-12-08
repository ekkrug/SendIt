//
//  Conversion.swift
//  SendIt
//
//  Created by Eugene Krug on 12/8/18.
//  Copyright © 2018 SendIt. All rights reserved.
//

import Foundation

struct Conversion
{
    static func feetToMeters(inFeet: Double) -> Double
    {
        let feet = Measurement(value: inFeet, unit: UnitLength.feet)
        let meters = feet.converted(to: UnitLength.meters)
        return meters.value
    }
    
    static func metersToFeet(inMeters: Double) -> Double
    {
        let meters = Measurement(value: inMeters, unit: UnitLength.meters)
        let feet = meters.converted(to: UnitLength.feet)
        return feet.value
    }
}
