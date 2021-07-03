//
//  DatabaseHelper.swift
//  WeatheriOSAssignment
//
//  Created by Madhuri Patil on 03/07/21.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static var sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object: [String: Any]) {
        let weather = NSEntityDescription.insertNewObject(forEntityName: "Weather", into: context!) as! Weather
        weather.cityname = object["cityname"] as? String
        weather.temp = object["temp"] as? String
        weather.date = object["date"] as? Date
        
        do {
            try context?.save()
        } catch {
            print("data is not save")
        }
    }
    
    func fetchWeatherData() -> [Weather] {
        var weather = [Weather]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Weather")
        
        do {
            weather = try context?.fetch(fetchRequest) as! [Weather]
        } catch {
            print("can not get data")
        }
        weather.sort(){$0.date! > $1.date!}
        return weather
    }
    
    func fetchSearchedData(city: String) -> [Weather] {
        var weather = [Weather]()
        let predicate = NSPredicate(format: "cityname contains [c] %@", city)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Weather")
        fetchRequest.predicate = predicate
        do {
            weather = try context?.fetch(fetchRequest) as! [Weather]
        } catch {
            print("can not get data")
        }
        return weather
    }
    
    func deleteData() -> [Weather] {
        var weather = fetchWeatherData()
        
        for (index,item) in weather.enumerated() {
            if let createdTime = item.date {
                let calendar = Calendar.current
                let now = Date()
                let earliest = (now as NSDate).earlierDate(createdTime)
                let latest = (earliest == now) ? createdTime : now
                let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
                
                if components.minute! >= 1 {
                    context?.delete(weather[index])
                    do {
                        try context?.save()
                    } catch {
                        print("can not delete data")
                    }
                }
            }
        }
        weather = fetchWeatherData()
        return weather
    }
}
