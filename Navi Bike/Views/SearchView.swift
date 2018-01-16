//
//  SearchView.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 16.01.2018.
//  Copyright © 2018 pkuzia. All rights reserved.
//

import UIKit

class SearchView: UIView {

    // MARK: - Outlets
    
    @IBOutlet weak var startPointTextField: UITextField!
    @IBOutlet weak var endPointTextField: UITextField!
    
    let searchViewModel = SearchViewModel()
    
    // MARK: - Appearance

    func initView() {
        startPointTextField.placeholder = searchViewModel.startPointPlaceholder
        endPointTextField.placeholder = searchViewModel.endPointPlaceholder
        startPointTextField.delegate = self
        endPointTextField.delegate = self
    }
    
    func resetTextFields() {
        startPointTextField.text = ""
        endPointTextField.text = ""
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
