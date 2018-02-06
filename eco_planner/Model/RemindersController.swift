//
//  RemindersController.swift
//  eco_planner
//
//  Created by user on 04/02/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit

class RemindersController: NSObject {

    static var sharedInstance = RemindersController()
    
    private var remindersArray:[Reminder] = []
    
    func addReminder(reminder: Reminder) {
        remindersArray.append(reminder)
    }
    
    func getReminders() -> [Reminder] {
        return remindersArray
    }
    
}
