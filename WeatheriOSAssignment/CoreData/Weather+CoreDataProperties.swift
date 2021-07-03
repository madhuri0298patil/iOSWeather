//
//  Weather+CoreDataProperties.swift
//  WeatheriOSAssignment
//
//  Created by Madhuri Patil on 03/07/21.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var cityname: String?
    @NSManaged public var temp: String?
    @NSManaged public var date: Date?

}

extension Weather : Identifiable {

}
