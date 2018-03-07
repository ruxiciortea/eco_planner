//
//  RemindersController.swift
//  eco_planner
//
//  Created by user on 04/02/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit

class RemindersController: NSObject {

    static let sharedInstance: RemindersController = RemindersController()

    private var remindersArray:[Reminder] = []

    private override init() {
        
    }
    
    func addReminder(newReminder: Reminder) {
        remindersArray.append(newReminder)
    }

    func getReminders() -> [Reminder] {
        return remindersArray
    }
    
    func removeReminder(index: Int) {
        if index >= remindersArray.count {
            return
        }
        
        remindersArray.remove(at: index)
    }
    
    func editReminder(_ index: Int, withReminder newReminder: Reminder) {
        if index >= remindersArray.count {
            return
        }
        
        let reminder = remindersArray[index]
        reminder.title = newReminder.title
        reminder.days = newReminder.days
        reminder.time = newReminder.time
    }
    
}
