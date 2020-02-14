//
//  WeatherBoardViewModel.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/13/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation

class WeatherBoardViewModel {
    // MARK: - Constants
    fileprivate let emptyString = ""
    fileprivate let currentDay: CurrentDay = CurrentDay(mainId: LocationIdentify.hochiminhId, mainTitle: "Clear", iconText: "01d", dayTemp: "25", nightTemp: "23", eveTemp: "24", morTemp: "24", minTemp: "23", maxTemp: "25")
    fileprivate let dayItems: [DayItemViewModel] = [DayItemViewModel(Forecast(time: "12345", iconText: "", minTemp: "24", maxTemp: "27"))
        , DayItemViewModel(Forecast(time: "12345", iconText: "", minTemp: "24", maxTemp: "27"))
        , DayItemViewModel(Forecast(time: "12345", iconText: "", minTemp: "24", maxTemp: "27"))
        , DayItemViewModel(Forecast(time: "12345", iconText: "", minTemp: "24", maxTemp: "27"))
        , DayItemViewModel(Forecast(time: "12345", iconText: "", minTemp: "24", maxTemp: "27"))]
    
    // MARK: - Properties
    let hasError: Observable<Bool>
    let errorMessage: Observable<String?>
    let locationIndex: Observable<Int>
    let weatherDetails: Observable<[WeatherDetailViewModel]>
    
    // MARK: - Services
    fileprivate var weatherService: WeatherServiceProtocol
    
    // MARK: - init
    init(locations: [WLocation]) {
        hasError = Observable(false)
        errorMessage = Observable(nil)
        locationIndex = Observable(0)
        
        var tempWeatherDetails: [WeatherDetailViewModel] = []
        for location in locations {
            tempWeatherDetails.append(WeatherDetailViewModel(location, curDay: CurrentDayViewModel(currentDay), dItems: dayItems))
        }
        weatherDetails = Observable(tempWeatherDetails)
        // Can put Dependency Injection here
        weatherService = OpenWeatherMapService()
    }
    
    // MARK: - public
    func getWeatherInformationFromServer(cityId: String) {
        weatherService.retrieveWeatherInfo(cityId) { (weather, error) -> Void in
          DispatchQueue.main.async(execute: {
            if let unwrappedError = error {
              print(unwrappedError)
              self.update(unwrappedError)
              return
            }

            guard let unwrappedWeather = weather else {
              return
            }
            self.update(unwrappedWeather)
          })
        }
    }

    // MARK: - private
    fileprivate func update(_ weather: Weather) {
        hasError.value = false
        errorMessage.value = nil

        for (i, item) in weatherDetails.value.enumerated() {
            if item.cityId.value == weather.location.id {
                locationIndex.value = i
                break
            }
        }
        
        var dayItems: [DayItemViewModel] = []
        for item in weather.forecasts {
            dayItems.append(DayItemViewModel(item))
        }
        weatherDetails.value[locationIndex.value] = WeatherDetailViewModel(weather.location, curDay: CurrentDayViewModel(weather.currentDay), dItems: dayItems)
    }

    fileprivate func update(_ error: WError) {
        hasError.value = true

        switch error.errorCode {
        case .urlError:
          errorMessage.value = "The weather service is not working."
        case .networkRequestFailed:
          errorMessage.value = "The network appears to be down."
        case .jsonSerializationFailed:
          errorMessage.value = "We're having trouble processing weather data."
        case .jsonParsingFailed:
          errorMessage.value = "We're having trouble parsing weather data."
        case .unableToFindLocation:
          errorMessage.value = "We're having trouble getting user location."
        }
    }
}
