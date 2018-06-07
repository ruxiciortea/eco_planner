//
//  ViewController.swift
//  eco_planner
//
//  Created by user on 30/01/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import ZAlertView
import UserNotifications

let kGreenColor = UIColor(named: "Green")
let kBlueColor = UIColor(named: "NavyBlue")
let kLightGreenColor = UIColor(named: "LightGreen")
let kBeigeColor = UIColor(named: "Beige")

class RemindersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var remindersTableView: UITableView!
    
    var selectedIndexPaht: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = kBlueColor
        RemindersViewController.addShadowsTo(view: (navigationController?.navigationBar)!, withOffSet: 2.0)
        RemindersViewController.addShadowsTo(view: (tabBarController?.tabBar)!, withOffSet: -2.0)
        
        self.remindersTableView.dataSource = self
        self.remindersTableView.delegate = self
        
        remindersTableView.reloadData()
    }
    
    // MARK: - Reminders TableView
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        remindersTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RemindersManager.sharedInstance.getReminders().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuse")
        let reminder = RemindersManager.sharedInstance.getReminders()[indexPath.row]
        
        cell.textLabel?.text = "\(formatateHour(number: reminder.time.hour)):\(formatateHour(number: reminder.time.minute))"
        cell.detailTextLabel?.text = "\(reminder.title)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPaht = indexPath
        self.performSegue(withIdentifier: "EditReminderSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        RemindersManager.sharedInstance.removeReminder(index: indexPath.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueDestination = (segue.destination as? UINavigationController)?.viewControllers.first as? AddOrEditReminderViewController
        
        guard segueDestination != nil else {
            return
        }
        
        segueDestination?.reminderAddedBlock = { (reminder) in
            RemindersManager.sharedInstance.addReminder(newReminder: reminder)
        }
        
        segueDestination?.reminderEditedBlock = { (reminder) in
            RemindersManager.sharedInstance.editReminder((self.selectedIndexPaht?.row)!, withReminder: reminder)
        }
        
        if segue.identifier == "EditReminderSegue" {
            segueDestination?.reminder = RemindersManager.sharedInstance.getReminders()[selectedIndexPaht!.row]
        }
    }
    
    // MARK: - Functions
    
    func formatateHour(number: Int) -> String {
        if number < 10 {
            let result = "0\(number)"
            return result
        }
        
        return "\(number)"
    }
    
    static func addShadowsTo(view: UIView, withOffSet _offset: Double) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: _offset)
        view.layer.shadowRadius = 2
    }
    
}

