//
//  Device.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/14/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct WScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}

struct WTime {
    static func isDay() -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())

        if hour >= 6 && hour < 18 {
            return true
        } else {
            return false
        }
    }
}


