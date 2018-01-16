//
//  HintsView.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 16.01.2018.
//  Copyright © 2018 pkuzia. All rights reserved.
//

import UIKit

class HintsView: UIView {

    // MARK: - Outlets

    @IBOutlet weak var nextHint: UILabel!
    @IBOutlet weak var currentHint: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Appearance
    
    func initView() {
        
    }
    
    func setHints(current: String, next: String) {
        nextHint.attributedText = StyleKit.attributedText(text: next.convertHtml(), attribute: .nextHintLabel)
        
        currentHint.attributedText = StyleKit.attributedText(text: current.convertHtml(), attribute: .currentHintLabel)
    }
}
