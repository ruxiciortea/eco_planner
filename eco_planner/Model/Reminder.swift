//
//  Reminder.swift
//  eco_planner
//
//  Created by user on 03/02/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit

class Reminder: NSObject {
    
    var title: String = ""
    var time: NSDate
    
//    var notification: UILocalNotification
    
    init(title: String, time: NSDate /*, notification: UILocalNotification*/ ) {
        self.title = title
        self.time = time
//        self.notification = notification
        
        super.init()
    }
}
