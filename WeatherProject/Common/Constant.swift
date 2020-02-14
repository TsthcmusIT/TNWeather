//
//  Constant.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/10/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation

struct Production {
    static let BASE_URL: String = "https://api.openweathermap.org/"
    static let API_Key: String = "fcb03c17ab6bb5606920752f712561de"
}

struct LocationIdentify {
    static let berlinId: String = "2950158"
    static let helsinkiId: String = "658226"
    static let hochiminhId: String = "1566083"
    static let londonId: String = "2643743"
    static let rioId: String = "3451189"
    static let stockholmId: String = "2673730"
    static let tokyoId: String = "1850147"
}

struct CoreDataDB {
    static let Location: String = "LocationStateDB"
    static let Weather: String = "WeatherDB"
}

struct Keys {
    static let LocationDidSelectedKey: String = "LocationDidSelected"
}

