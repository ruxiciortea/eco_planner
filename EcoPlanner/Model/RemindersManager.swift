//
//  RemindersController.swift
//  eco_planner
//
//  Created by user on 04/02/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

private let kReminderEntityName = "PersistentReminder"

class RemindersManager: NSObject {

    static let sharedInstance: RemindersManager = RemindersManager()

    private var remindersArray:[Reminder] = []

    private override init() {
        super.init()
        
        self.fetchFromCoreData()
    }
    
    //MARK: - CRUD Operations
    
    func getReminders() -> [Reminder] {
        return remindersArray
    }
    
    func addReminder(newReminder: Reminder) {
        remindersArray.append(newReminder)
        
        let persistentReminder = PersistentReminder(context: self.persistentContainer.viewContext)
        persistentReminder.title = newReminder.title
        persistentReminder.message = newReminder.message
        persistentReminder.days = Reminder.convertWeekDaysToInts(weekDays: newReminder.days)
        persistentReminder.time = [newReminder.time.hour, newReminder.time.minute]
        
        self.saveContext()
        
        self.scheduleNotification(forReminder: newReminder)
    }
    
    func editReminder(_ index: Int, withReminder newReminder: Reminder) {
        if index >= remindersArray.count {
            return
        }
        
        let reminder = self.remindersArray[index]
        
        let fetchRequest = getNSFetchRequestWithPredicate(reminder: reminder)
        
        do {
            if let result = (try self.persistentContainer.viewContext.fetch(fetchRequest) as! [PersistentReminder]).first {
                result.title = newReminder.title
                result.message = newReminder.message
                result.days = Reminder.convertWeekDaysToInts(weekDays: newReminder.days)
                result.time = [newReminder.time.hour, newReminder.time.minute]
                
                self.saveContext()
            }
        } catch {
        }
        
        reminder.title = newReminder.title
        reminder.message = newReminder.message
        reminder.days = newReminder.days
        reminder.time = newReminder.time
    }
    
    func removeReminder(index: Int) {
        if index >= remindersArray.count {
            return
        }
        
        let reminder = self.remindersArray[index]
        
        let fetchRequest = getNSFetchRequestWithPredicate(reminder: reminder)
        
        do {
            if let result = (try self.persistentContainer.viewContext.fetch(fetchRequest) as! [PersistentReminder]).first {
                self.persistentContainer.viewContext.delete(result)
                self.saveContext()
            }
        } catch {
        }
        
        remindersArray.remove(at: index)
    }
 
    // MARK: - Core Data

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Core Data")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
            }
        })
        return container
    }()

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func fetchFromCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: kReminderEntityName)

        do {
            let results = try persistentContainer.viewContext.fetch(request) as! [PersistentReminder]
            for data in results {
                let reminder = Reminder(fromPersistentReminder: data)
                remindersArray.append(reminder)
            }
        } catch {
            print("Fetch failed")
        }
    }
    
    // MARK: - Functions
    
    func getNSFetchRequestWithPredicate(reminder: Reminder) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kReminderEntityName)
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND message == %@ AND days == %@ AND time == %@",
                                             reminder.title,
                                             reminder.message ?? "",
                                             Reminder.convertWeekDaysToInts(weekDays: reminder.days),
                                             [reminder.time.hour, reminder.time.minute])
        
        return fetchRequest
    }
    
    // MARK: - Notifications
    
    private func scheduleNotification(forReminder reminder: Reminder) {
        let weekDays = Reminder.convertWeekDaysToInts(weekDays: reminder.days)
        
        for day in weekDays {
            let content = UNMutableNotificationContent()
            content.title = reminder.title
            content.body = reminder.message ?? ""
            
            var dateComponents = DateComponents()
            dateComponents.hour = reminder.time.hour
            dateComponents.minute = reminder.time.minute
            dateComponents.weekday = day
            
            // TODO: Check for weekdays and identifier
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "Reminder", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print(error)
                }
            }
        }
    }
}
