//
//  RemindersController.swift
//  eco_planner
//
//  Created by user on 04/02/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import CoreData

class RemindersController: NSObject {

    static let sharedInstance: RemindersController = RemindersController()

    private var remindersArray:[Reminder] = []

    private override init() {
        
    }
    
    func addReminder(newReminder: Reminder) {
        remindersArray.append(newReminder)
        
        let persistentReminder = PersistentReminder(context: self.persistentContainer.viewContext)
        persistentReminder.title = newReminder.title
        persistentReminder.days = Reminder.convertWeekDaysToInts(weekDays: newReminder.days)
        persistentReminder.time = [newReminder.time.hour, newReminder.time.minute]
        persistentReminder.message = newReminder.message
        
        self.saveContext()
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
        reminder.message = newReminder.message
    }
    
    func convertTime(time: (hour: Int, minute: Int)) -> [Int] {
        var convertedTime: [Int] = []
        
        convertedTime[0] = time.hour
        convertedTime[1] = time.minute
        
        return convertedTime
    }
    
    // MARK:- Core Data

    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func fetchFromCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PersistentReminder")

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
}
