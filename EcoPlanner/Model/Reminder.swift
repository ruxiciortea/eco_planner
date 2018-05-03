//
//  Reminder.swift
//  eco_planner
//
//  Created by user on 03/02/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit

enum WeekDay: Int {
    case monday = 1
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    init(weekDayNumber: Int) {
        switch weekDayNumber {
        case 1:
            self = .monday
        case 2:
            self = .tuesday
        case 3:
            self = .wednesday
        case 4:
            self = .thursday
        case 5:
            self = .friday
        case 6:
            self = .saturday
        case 7:
            self = .sunday
        default:
            print("Error on weekday init")
            self = .monday
        }
    }
    
    func stringValue() -> String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
    
    func letter() -> String {
        switch self {
        case .monday:
            return "M"
        case .tuesday, .thursday:
            return "T"
        case .wednesday:
            return "W"
        case .friday:
            return "F"
        case .saturday, .sunday:
            return "S"
        }
    }
    
    func weekdayForDateComponents() -> Int {
        let number = self.rawValue + 1
        
        if number == 8 {
            return 1
        }
        
        return number
    }
}

class Reminder: NSObject {
    
    var title: String
    var message: String?
    var days: [WeekDay]
    var time: (hour: Int, minute: Int)
    
    override init() {
        self.title = ""
        self.message = ""
        self.days = []
        self.time = (0, 0)

        super.init()
    }
    
    init(title: String, message: String?, days: [WeekDay], time: (hour: Int, minute: Int)) {
        self.title = title
        self.message = message
        self.days = days
        self.time = time
    }
    
}
