//
//  WeatherUtils.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/11/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation

struct WeatherIcon {
    let iconText: String
    let mainId: String
    let mainTitle: String

    enum IconType: String, CustomStringConvertible {
        case day200 = "day200"
        case day201 = "day201"
        case day202 = "day202"
        case day210 = "day210"
        case day211 = "day211"
        case day212 = "day212"
        case day221 = "day221"
        case day230 = "day230"
        case day231 = "day231"
        case day232 = "day232"
        case day300 = "day300"
        case day301 = "day301"
        case day302 = "day302"
        case day310 = "day310"
        case day311 = "day311"
        case day312 = "day312"
        case day313 = "day313"
        case day314 = "day314"
        case day321 = "day321"
        case day500 = "day500"
        case day501 = "day501"
        case day502 = "day502"
        case day503 = "day503"
        case day504 = "day504"
        case day511 = "day511"
        case day520 = "day520"
        case day521 = "day521"
        case day522 = "day522"
        case day531 = "day531"
        case day600 = "day600"
        case day601 = "day601"
        case day602 = "day602"
        case day611 = "day611"
        case day612 = "day612"
        case day615 = "day615"
        case day616 = "day616"
        case day620 = "day620"
        case day621 = "day621"
        case day622 = "day622"
        case day701 = "day701"
        case day711 = "day711"
        case day721 = "day721"
        case day731 = "day731"
        case day741 = "day741"
        case day751 = "day751"
        case day761 = "day761"
        case day762 = "day762"
        case day771 = "day771"
        case day781 = "day781"
        case day800 = "day800"
        case day801 = "day801"
        case day802 = "day802"
        case day803 = "day803"
        case day804 = "day804"
        case day900 = "day900"
        case day902 = "day902"
        case day903 = "day903"
        case day904 = "day904"
        case day906 = "day906"
        case day957 = "day957"
        case night200 = "night200"
        case night201 = "night201"
        case night202 = "night202"
        case night210 = "night210"
        case night211 = "night211"
        case night212 = "night212"
        case night221 = "night221"
        case night230 = "night230"
        case night231 = "night231"
        case night232 = "night232"
        case night300 = "night300"
        case night301 = "night301"
        case night302 = "night302"
        case night310 = "night310"
        case night311 = "night311"
        case night312 = "night312"
        case night313 = "night313"
        case night314 = "night314"
        case night321 = "night321"
        case night500 = "night500"
        case night501 = "night501"
        case night502 = "night502"
        case night503 = "night503"
        case night504 = "night504"
        case night511 = "night511"
        case night520 = "night520"
        case night521 = "night521"
        case night522 = "night522"
        case night531 = "night531"
        case night600 = "night600"
        case night601 = "night601"
        case night602 = "night602"
        case night611 = "night611"
        case night612 = "night612"
        case night615 = "night615"
        case night616 = "night616"
        case night620 = "night620"
        case night621 = "night621"
        case night622 = "night622"
        case night701 = "night701"
        case night711 = "night711"
        case night721 = "night721"
        case night731 = "night731"
        case night741 = "night741"
        case night751 = "night751"
        case night761 = "night761"
        case night762 = "night762"
        case night771 = "night771"
        case night781 = "night781"
        case night800 = "night800"
        case night801 = "night801"
        case night802 = "night802"
        case night803 = "night803"
        case night804 = "night804"
        case night900 = "night900"
        case night902 = "night902"
        case night903 = "night903"
        case night904 = "night904"
        case night906 = "night906"
        case night957 = "night957"

        var description: String {
            switch self {
                case .day200: return "11d"
                case .day201: return "11d"
                case .day202: return "11d"
                case .day210: return "11d"
                case .day211: return "11d"
                case .day212: return "11d"
                case .day221: return "11d"
                case .day230: return "11d"
                case .day231: return "11d"
                case .day232: return "11d"
                case .day300: return "09d"
                case .day301: return "09d"
                case .day302: return "09d"
                case .day310: return "09d"
                case .day311: return "09d"
                case .day312: return "09d"
                case .day313: return "09d"
                case .day314: return "09d"
                case .day321: return "09d"
                case .day500: return "10d"
                case .day501: return "10d"
                case .day502: return "10d"
                case .day503: return "10d"
                case .day504: return "10d"
                case .day511: return "13d"
                case .day520: return "09d"
                case .day521: return "09d"
                case .day522: return "09d"
                case .day531: return "09d"
                case .day600: return "13d"
                case .day601: return "13d"
                case .day602: return "13d"
                case .day611: return "13d"
                case .day612: return "13d"
                case .day615: return "13d"
                case .day616: return "13d"
                case .day620: return "13d"
                case .day621: return "13d"
                case .day622: return "13d"
                case .day701: return "50d"
                case .day711: return "50d"
                case .day721: return "50d"
                case .day731: return "50d"
                case .day741: return "50d"
                case .day751: return "50d"
                case .day761: return "50d"
                case .day762: return "50d"
                case .day771: return "50d"
                case .day781: return "50d"
                case .day800: if WTime.isDay() {return "01d"} else {return "01n"}
                case .day801: if WTime.isDay() {return "02d"} else {return "02n"}
                case .day802: if WTime.isDay() {return "03d"} else {return "03n"}
                case .day803: if WTime.isDay() {return "04d"} else {return "04n"}
                case .day804: if WTime.isDay() {return "04d"} else {return "04n"}
                case .day900: if WTime.isDay() {return "03d"} else {return "03n"}
                case .day902: if WTime.isDay() {return "03d"} else {return "03n"}
                case .day903: if WTime.isDay() {return "03d"} else {return "03n"}
                case .day904: if WTime.isDay() {return "03d"} else {return "03n"}
                case .day906: if WTime.isDay() {return "03d"} else {return "03n"}
                case .day957: if WTime.isDay() {return "03d"} else {return "03n"}
                case .night200: return "11d"
                case .night201: return "11d"
                case .night202: return "11d"
                case .night210: return "11d"
                case .night211: return "11d"
                case .night212: return "11d"
                case .night221: return "11d"
                case .night230: return "11d"
                case .night231: return "11d"
                case .night232: return "11d"
                case .night300: return "09d"
                case .night301: return "09d"
                case .night302: return "09d"
                case .night310: return "09d"
                case .night311: return "09d"
                case .night312: return "09d"
                case .night313: return "09d"
                case .night314: return "09d"
                case .night321: return "09d"
                case .night500: return "10d"
                case .night501: return "10d"
                case .night502: return "10d"
                case .night503: return "10d"
                case .night504: return "10d"
                case .night511: return "13d"
                case .night520: return "09d"
                case .night521: return "09d"
                case .night522: return "09d"
                case .night531: return "09d"
                case .night600: return "13d"
                case .night601: return "13d"
                case .night602: return "13d"
                case .night611: return "13d"
                case .night612: return "13d"
                case .night615: return "13d"
                case .night616: return "13d"
                case .night620: return "13d"
                case .night621: return "13d"
                case .night622: return "13d"
                case .night701: return "50d"
                case .night711: return "50d"
                case .night721: return "50d"
                case .night731: return "50d"
                case .night741: return "50d"
                case .night751: return "50d"
                case .night761: return "50d"
                case .night762: return "50d"
                case .night771: return "50d"
                case .night781: return "50d"
                case .night800: if WTime.isDay() {return "01d"} else {return "01n"}
                case .night801: if WTime.isDay() {return "02d"} else {return "02n"}
                case .night802: if WTime.isDay() {return "03d"} else {return "03n"}
                case .night803: if WTime.isDay() {return "04d"} else {return "04n"}
                case .night804: if WTime.isDay() {return "04d"} else {return "04n"}
                case .night900: if WTime.isDay() {return "03d"} else {return "03n"}
                case .night902: if WTime.isDay() {return "03d"} else {return "03n"}
                case .night903: if WTime.isDay() {return "03d"} else {return "03n"}
                case .night904: if WTime.isDay() {return "03d"} else {return "03n"}
                case .night906: if WTime.isDay() {return "03d"} else {return "03n"}
                case .night957: if WTime.isDay() {return "03d"} else {return "03n"}
            }
        }
        
        var title: String {
            switch self {
                case .day200: return "Thunderstorm"
                case .day201: return "Thunderstorm"
                case .day202: return "Thunderstorm"
                case .day210: return "Thunderstorm"
                case .day211: return "Thunderstorm"
                case .day212: return "Thunderstorm"
                case .day221: return "Thunderstorm"
                case .day230: return "Thunderstorm"
                case .day231: return "Thunderstorm"
                case .day232: return "Thunderstorm"
                case .day300: return "Drizzle"
                case .day301: return "Drizzle"
                case .day302: return "Drizzle"
                case .day310: return "Drizzle"
                case .day311: return "Drizzle"
                case .day312: return "Drizzle"
                case .day313: return "Drizzle"
                case .day314: return "Drizzle"
                case .day321: return "Drizzle"
                case .day500: return "Rain"
                case .day501: return "Rain"
                case .day502: return "Rain"
                case .day503: return "Rain"
                case .day504: return "Rain"
                case .day511: return "Rain"
                case .day520: return "Rain"
                case .day521: return "Rain"
                case .day522: return "Rain"
                case .day531: return "Rain"
                case .day600: return "Snow"
                case .day601: return "Snow"
                case .day602: return "Snow"
                case .day611: return "Snow"
                case .day612: return "Snow"
                case .day615: return "Snow"
                case .day616: return "Snow"
                case .day620: return "Snow"
                case .day621: return "Snow"
                case .day622: return "Snow"
                case .day701: return "Mist"
                case .day711: return "Smoke"
                case .day721: return "Haze"
                case .day731: return "Dust"
                case .day741: return "Fog"
                case .day751: return "Sand"
                case .day761: return "Dust"
                case .day762: return "Ash"
                case .day771: return "Squall"
                case .day781: return "Tornado"
                case .day800: return "Clear"
                case .day801: return "Clouds"
                case .day802: return "Clouds"
                case .day803: return "Clouds"
                case .day804: return "Clouds"
                case .day900: return "Clouds"
                case .day902: return "Clouds"
                case .day903: return "Clouds"
                case .day904: return "Clouds"
                case .day906: return "Clouds"
                case .day957: return "Clouds"
                case .night200: return "Thunderstorm"
                case .night201: return "Thunderstorm"
                case .night202: return "Thunderstorm"
                case .night210: return "Thunderstorm"
                case .night211: return "Thunderstorm"
                case .night212: return "Thunderstorm"
                case .night221: return "Thunderstorm"
                case .night230: return "Thunderstorm"
                case .night231: return "Thunderstorm"
                case .night232: return "Thunderstorm"
                case .night300: return "Drizzle"
                case .night301: return "Drizzle"
                case .night302: return "Drizzle"
                case .night310: return "Drizzle"
                case .night311: return "Drizzle"
                case .night312: return "Drizzle"
                case .night313: return "Drizzle"
                case .night314: return "Drizzle"
                case .night321: return "Drizzle"
                case .night500: return "Rain"
                case .night501: return "Rain"
                case .night502: return "Rain"
                case .night503: return "Rain"
                case .night504: return "Rain"
                case .night511: return "Rain"
                case .night520: return "Rain"
                case .night521: return "Rain"
                case .night522: return "Rain"
                case .night531: return "Rain"
                case .night600: return "Snow"
                case .night601: return "Snow"
                case .night602: return "Snow"
                case .night611: return "Snow"
                case .night612: return "Snow"
                case .night615: return "Snow"
                case .night616: return "Snow"
                case .night620: return "Snow"
                case .night621: return "Snow"
                case .night622: return "Snow"
                case .night701: return "Mist"
                case .night711: return "Smoke"
                case .night721: return "Haze"
                case .night731: return "Dust"
                case .night741: return "Fog"
                case .night751: return "Sand"
                case .night761: return "Dust"
                case .night762: return "Ash"
                case .night771: return "Squall"
                case .night781: return "Tornado"
                case .night800: return "Clear"
                case .night801: return "Clouds"
                case .night802: return "Clouds"
                case .night803: return "Clouds"
                case .night804: return "Clouds"
                case .night900: return "Clouds"
                case .night902: return "Clouds"
                case .night903: return "Clouds"
                case .night904: return "Clouds"
                case .night906: return "Clouds"
                case .night957: return "Clouds"
            }
        }
    }
    init(condition: Int, iconString: String) {
        var rawValue: String

        // if iconString has 'n', it means night time.
        if iconString.range(of: "n") != nil {
            rawValue = "night" + String(condition)
        } else {
            // day time
            rawValue = "day" + String(condition)
        }

        guard let iconType = IconType(rawValue: rawValue) else {
            mainId = ""
            iconText = ""
            mainTitle = ""
            return
        }
        
        mainId = String(condition)
        mainTitle = iconType.title
        iconText = iconType.description
    }
}

struct WeatherBuilder {
    var location: WLocation?
    var iconText: String?
    var mainId: String?
    var mainTitle: String?
    var dayTemp: String?
    var nightTemp: String?
    var eveTemp: String?
    var morTemp: String?
    var minTemp: String?
    var maxTemp: String?

    var forecasts: [Forecast]?

    func build() -> Weather {
        return Weather(location: location!, currentDay: CurrentDay(mainId: mainId!, mainTitle: mainTitle!, iconText: iconText!, dayTemp: dayTemp!, nightTemp: nightTemp!, eveTemp: eveTemp!, morTemp: morTemp!, minTemp: minTemp!, maxTemp: maxTemp!), forecasts: forecasts!)
    }
}

struct WLocation {
    let id: String
    let name: String
    var isSelected: Bool
    
    enum LocationType: String, CustomStringConvertible {
        case berlin = "2950158"
        case helsinki = "658226"
        case hochiminh = "1566083"
        case london = "2643743"
        case rio = "3451189"
        case stockholm = "2673730"
        case tokyo = "1850147"
        
        var description: String {
            switch self {
                case .berlin: return "Berlin"
                case .helsinki: return "Helsinki"
                case .hochiminh: return "Ho Chi Minh"
                case .london: return "London"
                case .rio: return "Rio"
                case .stockholm: return "Stockholm"
                case .tokyo: return "Tokyo"
            }
        }
    }
    
    init(condition: Int, selected: Bool) {
        let rawValue: String = String(condition)

        guard let locationType = LocationType(rawValue: rawValue) else {
            id = ""
            name = ""
            isSelected = false
            return
        }
        
        id = rawValue
        name = locationType.description
        isSelected = selected
    }
}

