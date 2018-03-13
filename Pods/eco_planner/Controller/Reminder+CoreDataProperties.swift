//
//  Reminder+CoreDataProperties.swift
//  
//
//  Created by user on 09/03/2018.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "PersistentReminder")
    }

    @NSManaged public var days: NSObject?
    @NSManaged public var message: String?
    @NSManaged public var time: NSObject?
    @NSManaged public var title: String?

}
