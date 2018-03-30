//
//  ViewController.swift
//  eco_planner
//
//  Created by user on 30/01/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import ZAlertView

let kNavyBlueColor = UIColor(named: "NavyBlue")
let kFadedBlueColor = UIColor(named: "FadedBlue")
let kTextColor = UIColor(named: "TextColor")

class RemindersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddReminderViewControllerDelegate {
 
    @IBOutlet weak var remindersTableView: UITableView!
    
    var selectedIndexPaht: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.remindersTableView.dataSource = self
        self.remindersTableView.delegate = self
        
        remindersTableView.reloadData()
        
        self.navigationController?.navigationBar.barTintColor = kNavyBlueColor
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        remindersTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RemindersController.sharedInstance.getReminders().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuse")
        let reminder = RemindersController.sharedInstance.getReminders()[indexPath.row]
        
        cell.textLabel?.text = "\(formatateHour(number: reminder.time.hour)):\(formatateHour(number: reminder.time.minute))"
        cell.detailTextLabel?.text = "\(reminder.title)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        RemindersController.sharedInstance.removeReminder(index: indexPath.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPaht = indexPath
        self.performSegue(withIdentifier: "EditReminderSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueDestination = (segue.destination as? UINavigationController)?.viewControllers.first as? AddReminderViewController
        
        guard segueDestination != nil else {
            return
        }
        
        segueDestination?.delegate = self
        
        segueDestination?.reminderAddedBlock = { (reminder) in
            RemindersController.sharedInstance.addReminder(newReminder: reminder)
        }
        
        segueDestination?.reminderEditedBlock = { (reminder) in
            RemindersController.sharedInstance.editReminder((self.selectedIndexPaht?.row)!, withReminder: reminder)
        }
        
        if segue.identifier == "EditReminderSegue" {
            segueDestination?.reminder = RemindersController.sharedInstance.getReminders()[selectedIndexPaht!.row]
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

