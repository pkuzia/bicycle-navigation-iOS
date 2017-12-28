//
//  ExampleViewController.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 12/28/17
//  Copyright (c) 2017 pkuzia. All rights reserved.
//

import UIKit

class ExampleViewController: BaseViewController {
    
    // MARK: - Outlets
    
    var exampleViewModel = ExampleViewModel()
    
    // MARK: - View Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    // MARK: - Appearance
    
    func initUI() {
        exampleViewModel.getRepositories("iteratorsmobile") { fetchResult in
            
        }
    }
    
    // MARK: - User Interaction
    
    // MARK: - Additional Helpers
    
}

// MARK: - ExampleViewModelDelegate

extension ExampleViewController: ExampleViewModelDelegate {
    
}
