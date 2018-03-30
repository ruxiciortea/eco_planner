//
//  AddReminderViewController.swift
//  eco_planner
//
//  Created by user on 07/02/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import ZAlertView

protocol AddReminderViewControllerDelegate: class {
}

class AddReminderViewController: UIViewController {
    
    @IBOutlet weak var saveReminderButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet var dayButtons: [UIButton]!
    
    var reminderAddedBlock: ((Reminder) -> ())?
    var reminderEditedBlock: ((Reminder) -> ())?
        
    var delegate: AddReminderViewControllerDelegate?
    var reminder: Reminder?
    
    var daysArrayIndex: Int?
    let ZAlerViewDismissDuration = 0.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = kNavyBlueColor
        
        if let reminder = self.reminder {
            titleTextField.text = reminder.title
            messageTextField.text = reminder.message
            selectDaysForEditingReminder(days: reminder.days)
            
            var dateComponents = DateComponents()
            dateComponents.hour = reminder.time.hour
            dateComponents.minute = reminder.time.minute

            if let date = Calendar.current.date(bySettingHour: reminder.time.hour, minute: reminder.time.minute, second: 0, of: Date()) {
                timePicker.date = date
            }
            
            saveReminderButton.isEnabled = true
        } else {
            let alertView: ZAlertView = ZAlertView(title: "Reminder type", message: nil, alertType: .multipleChoice)
            
            self.setZalertView(alertView: alertView, title: "1", message: "1")
            self.setZalertView(alertView: alertView, title: "2", message: "2")
            self.setZalertView(alertView: alertView, title: "Other", message: "")
            
            alertView.show()
        }
    }
    
    // MARK: - Actions:
    
    @IBAction func dayButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        saveReminderButton.isEnabled = self.titleTextField.text != nil && !self.titleTextField.text!.isEmpty
    }
    
    @IBAction func selectedButtonsCheck(_ sender: Any) {
        for button in dayButtons {
            if button.isSelected {
                saveReminderButton.isEnabled = true
                return
            }
        }
        
        saveReminderButton.isEnabled = false
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: self.timePicker.date)
        
        let title: String = self.titleTextField.text ?? "No title"
        let message: String? = self.messageTextField.text
        let days: [WeekDay] = self.getSelectedWeekDays()
        let time = (hour: components.hour!, minute: components.minute!)
        
        let newReminder = Reminder(title: title, message: message, days: days, time: time)
        
        if reminder == nil {
            self.reminderAddedBlock?(newReminder)
        } else {
            self.reminderEditedBlock?(newReminder)
        }
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Functions
    
    func getSelectedWeekDays() -> [WeekDay] {
        var selectedWeekDays: [WeekDay] = []

        for button in dayButtons {
            if button.isSelected == true {
                let weekday = WeekDay(weekDayNumber: button.tag)
                selectedWeekDays.append(weekday)
            }
        }
        
        return selectedWeekDays
    }
    
    func selectDaysForEditingReminder(days: [WeekDay]) {
        for day in days {
            for button in dayButtons {
                if button.restorationIdentifier == "\(day)" {
                    button.isSelected = true
                }
            }
        }
    }
    
    func setZalertView(alertView: ZAlertView, title: String, message: String) {
        alertView.addButton(title) { (_) in
            if title != "Other" {
                self.titleTextField.text = title
            } else {
                self.titleTextField.text = ""
            }
            
            self.messageTextField.text = message
            alertView.dismissWithDuration(self.ZAlerViewDismissDuration)
        }
    }
    
    //        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(smthTapped))
    //        gestureRecognizer.numberOfTapsRequired = 2
    //
    //        self.view.addGestureRecognizer(gestureRecognizer)
}
