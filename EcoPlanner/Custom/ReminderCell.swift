//
//  ReminderCell.swift
//  EcoPlanner
//
//  Created by user on 07/06/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit

class ReminderCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var dayButtons: [RoundButton]!
    
    func setReminderCell(reminder: Reminder) {
        timeLabel.text = "\(formatateHour(number: reminder.time.hour)):\(formatateHour(number: reminder.time.minute))"
        titleLabel.text = "\(reminder.title)"
        self.selectDaysForReminder(days: reminder.days)
        
    }
    
    func selectDaysForReminder(days: [WeekDay]) {
        for day in days {
            for button in buttons {
                if button.restorationIdentifier == "\(identifier)" {
                    button.activateButton(bool: true)
                }
            }
        }
    }
    
    func formatateHour(number: Int) -> String {
        if number < 10 {
            let result = "0\(number)"
            return result
        }
        
        return "\(number)"
    }

}
