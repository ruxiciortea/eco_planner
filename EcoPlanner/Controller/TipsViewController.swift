//
//  TipsViewController.swift
//  EcoPlanner
//
//  Created by user on 24/05/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import WebKit
import SystemConfiguration

class TipsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var connectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = kBlueColor
        RemindersViewController.addShadowsTo(view: (navigationController?.navigationBar)!, withOffSet: 2.0)
        RemindersViewController.addShadowsTo(view: (tabBarController?.tabBar)!, withOffSet: -2.0)
        
        if self.connection() == false {
            self.connectionLabel.isHidden = false
            self.connectionLabel.text = "No internet connection."
        } else {
            let url = URL(string: "https://www.reusethisbag.com/articles/top-23-best-recycling-tips/")
            let request = URLRequest(url: url!)
            
            self.webView.load(request)
        }
      
    }

    func connection() -> Bool {
        return true
    }
    
}
