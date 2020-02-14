//
//  DayItemViewModel.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/11/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation

struct DayItemViewModel {
    let time: Observable<String>
    let iconText: Observable<String>
    let minTemp: Observable<String>
    let maxTemp: Observable<String>

    init(_ forecast: Forecast) {
        time = Observable(forecast.time)
        iconText = Observable(forecast.iconText)
        minTemp = Observable(forecast.minTemp)
        maxTemp = Observable(forecast.maxTemp)
    }
}
