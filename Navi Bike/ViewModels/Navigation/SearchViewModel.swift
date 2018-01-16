//
//  SearchViewModel.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 16.01.2018.
//Copyright © 2018 pkuzia. All rights reserved.
//

import UIKit

protocol SearchViewModelDelegate: class {
    
}

class SearchViewModel: BaseViewModel {
    
    // MARK: - Strings
    
    let startPointPlaceholder = "start_point_placeholder".localized
    let endPointPlaceholder = "end_point_placeholder".localized
    
    // MARK: - View Model Data
    
    weak var delegate: SearchViewModelDelegate?
    
    // MARK: - Functions
}


