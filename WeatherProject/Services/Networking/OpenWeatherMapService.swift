//
//  OpenWeatherMapService.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/11/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

struct OpenWeatherMapService: WeatherServiceProtocol {
    fileprivate let urlPath = Production.BASE_URL + "data/2.5/forecast"
    
    fileprivate func getFirstFourForecasts(_ json: JSON) -> [Forecast] {
        var forecasts: [Forecast] = []
        
        for index in 0...4 {
            guard let forecastTempDegrees = json["list"][index]["main"]["temp"].double,
                let rawDateTime = json["list"][index]["dt"].double,
                let forecastCondition = json["list"][index]["weather"][0]["id"].int,
                let forecastIcon = json["list"][index]["weather"][0]["icon"].string else {
                    break
            }
            
            let country = json["city"]["country"].string
            _ = Temperature(country: country!,
                                                  openWeatherMapDegrees: forecastTempDegrees)
            let forecastTimeString = ForecastDateTime(date: rawDateTime, timeZone: TimeZone.current).shortTime
            print("timeabc \(forecastTimeString) \(rawDateTime)" )
            let weatherIcon = WeatherIcon(condition: forecastCondition, iconString: forecastIcon)
            let forcastIconText = weatherIcon.iconText
            
            let minTemp = json["list"][index]["main"]["temp_min"].double!
            let maxTemp = json["list"][index]["main"]["temp_max"].double!
            let minTemperature = Temperature(country: country!, openWeatherMapDegrees:minTemp)
            let maxTemperature = Temperature(country: country!, openWeatherMapDegrees:maxTemp)
            
            let forecast = Forecast(time: forecastTimeString,
                                    iconText: forcastIconText,
                                    minTemp: String(minTemperature.degrees),
                                    maxTemp: String(maxTemperature.degrees))
            
            forecasts.append(forecast)
        }
        
        return forecasts
    }
    
    func retrieveWeatherInfo(_ cityId: String, completionHandler: @escaping WeatherCompletionHandler) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard let url = generateRequestURL(cityId) else {
            let error = WError(errorCode: .urlError)
            completionHandler(nil, error)
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check network error
            guard error == nil else {
                let error = WError(errorCode: .networkRequestFailed)
                completionHandler(nil, error)
                return
            }
            
            // Check JSON serialization error
            guard let data = data else {
                let error = WError(errorCode: .jsonSerializationFailed)
                completionHandler(nil, error)
                return
            }
            
            guard let json = try? JSON(data: data) else {
                let error = WError(errorCode: .jsonParsingFailed)
                completionHandler(nil, error)
                return
            }
            
            // Get temperature, location and icon and check parsing error
            guard let dayTemp = json["list"][0]["main"]["temp"].double,
                let nightTemp = json["list"][0]["main"]["temp"].double,
                let eveTemp = json["list"][0]["main"]["temp"].double,
                let morTemp = json["list"][0]["main"]["temp"].double,
                let minTemp = json["list"][0]["main"]["temp_min"].double,
                let maxTemp = json["list"][0]["main"]["temp_max"].double,
                let country = json["city"]["country"].string,
                let _ = json["city"]["name"].string,
                let weatherCondition = json["list"][0]["weather"][0]["id"].int,
                let iconString = json["list"][0]["weather"][0]["icon"].string else {
                    let error = WError(errorCode: .jsonParsingFailed)
                    completionHandler(nil, error)
                    return
            }
            
            var weatherBuilder = WeatherBuilder()
            let dayTemperature = Temperature(country: country, openWeatherMapDegrees:dayTemp)
            let nightTemperature = Temperature(country: country, openWeatherMapDegrees:nightTemp)
            let eveTemperature = Temperature(country: country, openWeatherMapDegrees:eveTemp)
            let morTemperature = Temperature(country: country, openWeatherMapDegrees:morTemp)
            let minTemperature = Temperature(country: country, openWeatherMapDegrees:minTemp)
            let maxTemperature = Temperature(country: country, openWeatherMapDegrees:maxTemp)
            weatherBuilder.dayTemp = dayTemperature.degrees
            weatherBuilder.nightTemp = nightTemperature.degrees
            weatherBuilder.eveTemp = eveTemperature.degrees
            weatherBuilder.morTemp = morTemperature.degrees
            weatherBuilder.minTemp = minTemperature.degrees
            weatherBuilder.maxTemp = maxTemperature.degrees
            weatherBuilder.location = WLocation(condition: Int(cityId)!, selected: true)
            
            let weatherIcon = WeatherIcon(condition: weatherCondition, iconString: iconString)
            weatherBuilder.iconText = weatherIcon.iconText
            weatherBuilder.mainId = String(weatherCondition)
            weatherBuilder.mainTitle = weatherIcon.mainTitle
            weatherBuilder.forecasts = self.getFirstFourForecasts(json)
            
            completionHandler(weatherBuilder.build(), nil)
        }
        
        task.resume()
    }
    
    fileprivate func generateRequestURL(_ cityId: String) -> URL? {
        guard var components = URLComponents(string:urlPath) else {
            return nil
        }
        
        let appId = Production.API_Key
        
        components.queryItems = [URLQueryItem(name:"id", value:cityId),
                                 URLQueryItem(name:"cnt", value:String(6)),
                                 URLQueryItem(name:"APPID", value:appId),
                                 URLQueryItem(name:"units", value:"metric")]
        
        return components.url
    }
}
