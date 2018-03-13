//
//  Reminder+CoreDataProperties.swift
//  eco_planner
//
//  Created by user on 12/03/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//
//

import Foundation
import CoreData

extension PersistentReminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentReminder> {
        return NSFetchRequest<PersistentReminder>(entityName: "PersistentReminder")
    }
    
    @NSManaged public var title: String
    @NSManaged public var days: [Int]
    @NSManaged public var time: [Int]
    @NSManaged public var message: String?
}
