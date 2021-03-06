//
//  MainNavigationViewController.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 28.12.2017.
//  Copyright © 2017 pkuzia. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
}
