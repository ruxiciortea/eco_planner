//
//  ViewController.swift
//  eco_planner
//
//  Created by user on 30/01/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit

class ViewRemindersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var remindersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RemindersController.sharedInstance.getReminders().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuse")
        
        return cell
    }
    
}

