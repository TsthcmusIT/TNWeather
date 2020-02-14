//
//  WeatherInfo.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/11/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation

struct Weather {
    let location: WLocation
    let currentDay: CurrentDay
    let forecasts: [Forecast]
}

struct CurrentDay {
    let mainId: String
    let mainTitle: String
    let iconText: String
    let dayTemp: String
    let nightTemp: String
    let eveTemp: String
    let morTemp: String
    let minTemp: String
    let maxTemp: String
}

struct Forecast {
    let time: String
    let iconText: String
    let minTemp: String
    let maxTemp: String
}

struct Temperature {
    let degrees: String

    init(country: String, openWeatherMapDegrees: Double) {
        if country == "US" {
            degrees = String(TemperatureConverter.kelvinToFahrenheit(openWeatherMapDegrees))
        } else if country == "VN" {
            degrees = String(TemperatureConverter.notChange(openWeatherMapDegrees))
        } else {
            degrees = String(TemperatureConverter.notChange(openWeatherMapDegrees))
//            degrees = String(TemperatureConverter.kelvinToCelsius(openWeatherMapDegrees))
        }
    }
}



