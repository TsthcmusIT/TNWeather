//
//  DataBaseManger.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/13/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataBaseManger: NSObject {
    // MARK: LocationDB
    class func loadAllLocationDB() -> [WLocation] {
        var location: [WLocation] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return location
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
      
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: CoreDataDB.Location)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for object in result as! [NSManagedObject] {
                location.append(WLocation(condition: (object.value(forKey: "id") as! NSString).integerValue, selected: object.value(forKey: "isSelected") as! Bool))
            }
        } catch {
            print("Location DB save failed")
        }
        
        return location
    }
    
    class func loadLocationSelectedDB() -> [WLocation] {
        var location: [WLocation] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return location
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
      
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: CoreDataDB.Location)
        fetchRequest.predicate = NSPredicate(format: "isSelected = %d", true)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for object in result as! [NSManagedObject] {
                location.append(WLocation(condition: (object.value(forKey: "id") as! NSString).integerValue, selected: object.value(forKey: "isSelected") as! Bool))
            }
        } catch {
            print("Location DB save failed")
        }
        
        return location
    }
    
    class func saveLocationDB(locations: [WLocation]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
      
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: CoreDataDB.Location as String)
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count <= 0 {
                let userEntity = NSEntityDescription.entity(forEntityName: CoreDataDB.Location, in: managedContext)!
                for location in locations {
                    let item = NSManagedObject(entity: userEntity, insertInto: managedContext)
                    item.setValue(location.id, forKey: "id")
                    item.setValue(location.name, forKey: "name")
                    item.setValue(location.isSelected, forKey: "isSelected")
                }
                
                try managedContext.save()
            }
        } catch {
            print("Location DB save failed")
        }
    }
    
    class func updateLocationDB(locations: [WLocation]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
      
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: CoreDataDB.Location)
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            for (index, objectUpdate) in result.enumerated() {
                (objectUpdate as! NSManagedObject).setValue(locations[index].id, forKey: "id")
                (objectUpdate as! NSManagedObject).setValue(locations[index].name, forKey: "name")
                (objectUpdate as! NSManagedObject).setValue(locations[index].isSelected, forKey: "isSelected")
            }
            
            try managedContext.save()
        } catch {
            print("Location DB save failed")
        }
    }
    
    // MARK: - WeatherDB
    class func loadWeatherDB(locationId: String) -> Weather? {
        var weather: Weather?
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return weather
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
      
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: CoreDataDB.Weather)
        fetchRequest.predicate = NSPredicate(format: "id = %d", locationId)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            if result.count == 6 {
                let location = WLocation(condition: Int(locationId)!, selected: true)
                var currentDay: CurrentDay?
                var dayItems: [Forecast]?
                for (index, element) in result.enumerated() {
                    let mainId = (element as! NSManagedObject).value(forKey: "mainId") as! String
                    let mainTitle = (element as! NSManagedObject).value(forKey: "mainTitle") as! String
                    let iconText = (element as! NSManagedObject).value(forKey: "iconText") as! String
                    let time = (element as! NSManagedObject).value(forKey: "time") as! String
                    let dayTemp = (element as! NSManagedObject).value(forKey: "dayTemp") as! String
                    let nightTemp = (element as! NSManagedObject).value(forKey: "nightTemp") as! String
                    let eveTemp = (element as! NSManagedObject).value(forKey: "eveTemp") as! String
                    let morTemp = (element as! NSManagedObject).value(forKey: "morTemp") as! String
                    let minTemp = (element as! NSManagedObject).value(forKey: "minTemp") as! String
                    let maxTemp = (element as! NSManagedObject).value(forKey: "maxTemp") as! String
                    
                    if index == 5 {
                        currentDay = CurrentDay(mainId: mainId, mainTitle: mainTitle, iconText: iconText, dayTemp: dayTemp, nightTemp: nightTemp, eveTemp: eveTemp, morTemp: morTemp, minTemp: minTemp, maxTemp: maxTemp)
                    } else {
                        dayItems?.append(Forecast(time: time, iconText: iconText, minTemp: minTemp, maxTemp: maxTemp))
                    }
                }
                
                weather = Weather(location: location, currentDay: currentDay!, forecasts: dayItems!)
            }
            
        } catch {
            print("Location DB save failed")
        }
        
        return weather
    }
    
    class func updateWeatherDB(weather: Weather) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
      
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: CoreDataDB.Weather)
        do {
            let result = try managedContext.fetch(fetchRequest)
            let numberOfRecord = result.count
            let numberOfForecast = weather.forecasts.count + 1
            
            if numberOfRecord <= 0 || (numberOfRecord != numberOfForecast) {
                if numberOfRecord != numberOfForecast {
                    
                    for item in result {
                        managedContext.delete(item as! NSManagedObject)
                    }
                }
                
                let userEntity = NSEntityDescription.entity(forEntityName: CoreDataDB.Weather, in: managedContext)!
                for i in 0...(numberOfForecast - 1) {
                    let item = NSManagedObject(entity: userEntity, insertInto: managedContext)
                    
                    item.setValue(weather.location.id, forKey: "id")
                    item.setValue(weather.location.name, forKey: "location")
                    item.setValue(weather.currentDay.mainId, forKey: "mainId")
                    item.setValue(weather.currentDay.mainTitle, forKey: "mainTitle")
                    item.setValue(weather.currentDay.iconText, forKey: "iconText")
                    
                    if i == numberOfForecast - 1 {
                        item.setValue("", forKey: "time")
                        item.setValue(weather.currentDay.minTemp, forKey: "minTemp")
                        item.setValue(weather.currentDay.maxTemp, forKey: "maxTemp")
                        item.setValue(weather.currentDay.morTemp, forKey: "morTemp")
                        item.setValue(weather.currentDay.eveTemp, forKey: "eveTemp")
                        item.setValue(weather.currentDay.dayTemp, forKey: "dayTemp")
                        item.setValue(weather.currentDay.nightTemp, forKey: "nightTemp")
                    } else {
                        item.setValue(weather.forecasts[i].time, forKey: "time")
                        item.setValue(weather.forecasts[i].minTemp, forKey: "minTemp")
                        item.setValue(weather.forecasts[i].maxTemp, forKey: "maxTemp")
                        item.setValue("", forKey: "morTemp")
                        item.setValue("", forKey: "eveTemp")
                        item.setValue("", forKey: "dayTemp")
                        item.setValue("", forKey: "nightTemp")
                    }
                }
            } else {
                for (index, objectUpdate) in result.enumerated() {
                    (objectUpdate as! NSManagedObject).setValue(weather.location.id, forKey: "id")
                    (objectUpdate as! NSManagedObject).setValue(weather.location.name, forKey: "location")
                    (objectUpdate as! NSManagedObject).setValue(weather.currentDay.mainId, forKey: "mainId")
                    (objectUpdate as! NSManagedObject).setValue(weather.currentDay.mainTitle, forKey: "mainTitle")
                    (objectUpdate as! NSManagedObject).setValue(weather.currentDay.iconText, forKey: "iconText")
                    
                    if index == numberOfForecast - 1 {
                        (objectUpdate as! NSManagedObject).setValue("", forKey: "time")
                        (objectUpdate as! NSManagedObject).setValue(weather.currentDay.minTemp, forKey: "minTemp")
                        (objectUpdate as! NSManagedObject).setValue(weather.currentDay.maxTemp, forKey: "maxTemp")
                        (objectUpdate as! NSManagedObject).setValue(weather.currentDay.morTemp, forKey: "morTemp")
                        (objectUpdate as! NSManagedObject).setValue(weather.currentDay.eveTemp, forKey: "eveTemp")
                        (objectUpdate as! NSManagedObject).setValue(weather.currentDay.dayTemp, forKey: "dayTemp")
                        (objectUpdate as! NSManagedObject).setValue(weather.currentDay.nightTemp, forKey: "nightTemp")
                    } else {
                        (objectUpdate as! NSManagedObject).setValue(weather.forecasts[index].time, forKey: "time")
                        (objectUpdate as! NSManagedObject).setValue(weather.forecasts[index].minTemp, forKey: "minTemp")
                        (objectUpdate as! NSManagedObject).setValue(weather.forecasts[index].maxTemp, forKey: "maxTemp")
                        (objectUpdate as! NSManagedObject).setValue("", forKey: "morTemp")
                        (objectUpdate as! NSManagedObject).setValue("", forKey: "eveTemp")
                        (objectUpdate as! NSManagedObject).setValue("", forKey: "dayTemp")
                        (objectUpdate as! NSManagedObject).setValue("", forKey: "nightTemp")
                    }
                    
                }
            }
            
            try managedContext.save()
        } catch {
            print("WeatherDB save failed")
        }
    }
}
