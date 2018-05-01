//
//  Reminder+PersistentReminder.swift
//  eco_planner
//
//  Created by user on 13/03/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import Foundation

extension Reminder {
    convenience init(fromPersistentReminder persistentReminder: PersistentReminder) {
        self.init()
        
        self.title = persistentReminder.title
        self.message = persistentReminder.message
        self.time.hour = persistentReminder.time[0]
        self.time.minute = persistentReminder.time[1]
        self.days = Reminder.convertIntsToWeekDays(days: persistentReminder.days)
    }
    
    static func convertIntsToWeekDays(days: [Int]) -> [WeekDay] {
        var daysArray: [WeekDay] = []
        
        for day in days {
            let weekDay = WeekDay(weekDayNumber: day)
            daysArray.append(weekDay)
        }
        
        return daysArray
    }
    
    static func convertWeekDaysToInts(weekDays: [WeekDay]) -> [Int] {
        var daysArray: [Int] = []
        
        for weekDay in weekDays {
            let day = weekDay.rawValue
            daysArray.append(day)
        }
        
        return daysArray
    }
    
}
