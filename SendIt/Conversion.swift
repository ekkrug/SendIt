//
//  Conversion.swift
//  SendIt
//  This file implements the Conversion struct.
//  CPSC 315-01, Fall 2018
//  Project
//
//  Published by Eugene Krug and Kevin Mattappally on 12/12/18.
//  Copyright © 2018 Eugene Krug and Kevin Mattappally. All rights reserved.
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
