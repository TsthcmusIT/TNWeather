//
//  ForecastDateTime.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/11/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation

struct ForecastDateTime {
    let rawDate: Double
    let timeZone: TimeZone
    
    init(date: Double, timeZone: TimeZone) {
        self.timeZone = timeZone
        self.rawDate = date
    }
    
    var shortTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "EEEE"
        let date = Date(timeIntervalSince1970: rawDate)
        return dateFormatter.string(from: date)
    }
}
