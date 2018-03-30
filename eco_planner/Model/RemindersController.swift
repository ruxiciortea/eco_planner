//
//  RemindersController.swift
//  eco_planner
//
//  Created by user on 04/02/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import CoreData

private let kReminderEntityName = "PersistentReminder"

class RemindersController: NSObject {

    static let sharedInstance: RemindersController = RemindersController()

    private var remindersArray:[Reminder] = []

    private override init() {
        super.init()
        
        self.fetchFromCoreData()
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
        
        let reminder = self.remindersArray[index]
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kReminderEntityName)
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND time == %@ AND days == %@ AND message == %@",
                                             reminder.title,
                                             [reminder.time.hour, reminder.time.minute],
                                             Reminder.convertWeekDaysToInts(weekDays: reminder.days),
                                             reminder.message ?? "")
        
        do {
            if let result = (try self.persistentContainer.viewContext.fetch(fetchRequest) as! [PersistentReminder]).first {
                self.persistentContainer.viewContext.delete(result)
                self.saveContext()
            }
        } catch {
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
}
