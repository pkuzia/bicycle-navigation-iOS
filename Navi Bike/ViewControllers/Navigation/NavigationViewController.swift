//
//  NavigationViewController.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 28.12.2017.
//Copyright © 2017 pkuzia. All rights reserved.
//

import UIKit

class NavigationViewController: BaseViewController {
    
    // MARK: - Outlets
    
    let navigationViewModel = NavigationViewModel()
    
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
        navigationViewModel.navigationRoute(startPoint: Point(lat: 52.250771, lng: 20.845112),
                                            endPoint: Point(lat: 52.231290, lng: 20.956922)) { result in
            
        }
    }
    
    // MARK: - User Interaction
    
    // MARK: - Additional Helpers
    
}

// MARK: - NavigationViewControllerViewModelDelegate

extension NavigationViewController: NavigationViewModelDelegate {
    
}

