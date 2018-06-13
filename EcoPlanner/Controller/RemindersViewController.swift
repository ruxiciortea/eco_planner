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
let kClearColor = UIColor(named: "ClearColor")

class RemindersViewController: UIViewController {
 
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        remindersTableView.reloadData()
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
    
    static func addShadowsTo(view: UIView, withOffSet _offset: Double) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: _offset)
        view.layer.shadowRadius = 2
    }
    
}

extension RemindersViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RemindersManager.sharedInstance.getReminders().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell") as! ReminderCell
        let reminder = RemindersManager.sharedInstance.getReminders()[indexPath.row]
        
        UIView.animate(withDuration: 0.2) {
            cell.setReminderCell(reminder: reminder)
        }
        
        return cell
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
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPaht = indexPath
        self.performSegue(withIdentifier: "EditReminderSegue", sender: nil)
    }
    
}

