//
//  WeatherDetailViewModel.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/12/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation

class WeatherDetailViewModel {
    let cityId: Observable<String>
    let cityName: Observable<String>
    let currentDay: Observable<CurrentDayViewModel>
    let dayItems: Observable<[DayItemViewModel]>

    // MARK: - init
    init(_ location: WLocation, curDay: CurrentDayViewModel, dItems: [DayItemViewModel]) {
        cityId = Observable(location.id)
        cityName = Observable(location.name)
        currentDay = Observable(curDay)
        dayItems = Observable(dItems)
    }
}
