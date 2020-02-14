//
//  TemperatureUtils.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/11/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation

struct TemperatureConverter {
    static func kelvinToCelsius(_ degrees: Double) -> Int {
        return Int(round(degrees - 273.15))
    }

    static func kelvinToFahrenheit(_ degrees: Double) -> Int {
        return Int(round(degrees * 9 / 5 - 459.67))
    }
    
    static func notChange(_ degrees: Double) -> Int {
        return Int(round(degrees))
    }
}
