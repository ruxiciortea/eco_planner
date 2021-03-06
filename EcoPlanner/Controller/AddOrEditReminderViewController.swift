//
//  AddReminderViewController.swift
//  eco_planner
//
//  Created by user on 07/02/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import ZAlertView

class AddOrEditReminderViewController: UIViewController {
    
    @IBOutlet weak var saveReminderButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet var dayButtons: [RoundButton]!
    
    @IBOutlet weak var scrollViewBottomMarginConstraint: NSLayoutConstraint!
    
    var reminderAddedBlock: ((Reminder) -> ())?
    var reminderEditedBlock: ((Reminder) -> ())?
        
    var reminder: Reminder?
    var daysArrayIndex: Int?
    var buttonsCheck = false
    var textFieldCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = kBlueColor
        RemindersViewController.addShadowsTo(view: (navigationController?.navigationBar)!, withOffSet: 2.0)
        self.timePicker.setValue(kBlueColor, forKey: "textColor")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShowNotification(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHideNotification(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.reminder == nil {
            let alertView: ZAlertView = ZAlertView(title: "Reminder type", message: nil, alertType: .multipleChoice)
            
            self.setZalertView(alertView: alertView, title: "Recycling day", message: "")
            self.setZalertView(alertView: alertView, title: "Other", message: "")
            
            alertView.show()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let reminder = self.reminder {
            UIView.animate(withDuration: 0.2) {
                self.titleTextField.text = reminder.title
                self.messageTextField.text = reminder.message
                self.selectDaysForEditingReminder(days: reminder.days)
                
                var dateComponents = DateComponents()
                dateComponents.hour = reminder.time.hour
                dateComponents.minute = reminder.time.minute
                
                if let date = Calendar.current.date(bySettingHour: reminder.time.hour, minute: reminder.time.minute, second: 0, of: Date()) {
                    self.timePicker.date = date
                }
            }
            
            self.saveReminderButton.isEnabled = true
            self.buttonsCheck = true
            self.textFieldCheck = true
        }
    }
    
    // MARK: - Actions:

    @IBAction func textFieldChanged(_ sender: Any) {
        if self.titleTextField.text?.isEmpty == false {
            self.textFieldCheck = true
            
            if self.buttonsCheck {
                self.saveReminderButton.isEnabled = true
            }
        } else {
            self.textFieldCheck = false
            self.saveReminderButton.isEnabled = false
        }
    }
    
    @IBAction func selectedButtonsCheck(_ sender: Any) {
        for button in dayButtons {
            if button.isOn {
                self.buttonsCheck = true
                
                if self.textFieldCheck {
                    self.saveReminderButton.isEnabled = true
                }
                
                return
            }
        }
        
        self.buttonsCheck = false
        self.saveReminderButton.isEnabled = false
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
    
    //MARK: - Private Functions
    
    private func getSelectedWeekDays() -> [WeekDay] {
        var selectedWeekDays: [WeekDay] = []

        for button in dayButtons {
            if button.isOn == true {
                let weekday = WeekDay(weekDayNumber: button.tag)
                selectedWeekDays.append(weekday)
            }
        }
        
        return selectedWeekDays
    }
    
    private func selectDaysForEditingReminder(days: [WeekDay]) {
        for day in days {
            for button in dayButtons {
                if button.restorationIdentifier == "\(day)" {
                    button.activateButton(bool: true)
                }
            }
        }
    }
    
    private func setZalertView(alertView: ZAlertView, title: String, message: String) {
        alertView.addButton(title, color: kBlueColor, titleColor: kLightGreenColor) { (_) in
            if title != "Other" {
                self.titleTextField.text = title
                self.textFieldCheck = true
            } else {
                self.titleTextField.text = ""
            }
            
            self.messageTextField.text = message
            alertView.dismissWithDuration(0.2)
        }
    }
    
    // MARK: - Keyboard notifications
    
    @objc func keyboardWillShowNotification(notification: Notification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        self.scrollViewBottomMarginConstraint.constant = keyboardHeight
    }
    
    @objc func keyboardWillHideNotification(notification: Notification) {
        self.scrollViewBottomMarginConstraint.constant = 0
    }

}
