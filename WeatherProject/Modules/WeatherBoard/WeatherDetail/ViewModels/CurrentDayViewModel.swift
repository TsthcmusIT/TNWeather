//
//  CurrentDayViewModel.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/11/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation

struct CurrentDayViewModel {
    let mainId: Observable<String>
    let mainTitle: Observable<String>
    let iconText: Observable<String>
    let dayTemp: Observable<String>
    let nightTemp: Observable<String>
    let eveTemp: Observable<String>
    let morTemp: Observable<String>
    let minTemp: Observable<String>
    let maxTemp: Observable<String>

    init(_ currentDay: CurrentDay) {
        mainId = Observable(currentDay.mainId)
        mainTitle = Observable(currentDay.mainTitle)
        iconText = Observable(currentDay.iconText)
        dayTemp = Observable(currentDay.dayTemp)
        nightTemp = Observable(currentDay.nightTemp)
        eveTemp = Observable(currentDay.eveTemp)
        morTemp = Observable(currentDay.morTemp)
        minTemp = Observable(currentDay.minTemp)
        maxTemp = Observable(currentDay.maxTemp)
    }
}
