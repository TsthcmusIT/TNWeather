//
//  WeatherServiceProtocol.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/11/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation
import CoreLocation

typealias WeatherCompletionHandler = (Weather?, WError?) -> Void

protocol WeatherServiceProtocol {
    func retrieveWeatherInfo(_ cityId: String, completionHandler: @escaping WeatherCompletionHandler)
}
