//
//  TipsViewController.swift
//  EcoPlanner
//
//  Created by user on 24/05/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import WebKit

class TipsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RemindersViewController.addShadowsTo(view: (tabBarController?.tabBar)!, withOffSet: -2.0)
        
        let url = URL(string: "https://www.reusethisbag.com/articles/top-23-best-recycling-tips/")
        let request = URLRequest(url: url!)
        
        self.webView.load(request)
    }

}
