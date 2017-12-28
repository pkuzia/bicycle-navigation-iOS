//
//  NavigationViewModel.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 28.12.2017.
//Copyright © 2017 pkuzia. All rights reserved.
//

import UIKit

protocol NavigationViewModelDelegate: class {
    
}

class NavigationViewModel: BaseViewModel {
    
    // MARK: - Strings
    
    // MARK: - View Model Data
    
    weak var delegate: NavigationViewModelDelegate?
    
    // MARK: - Functions
}


