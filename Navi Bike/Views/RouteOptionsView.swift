//
//  RouteOptionsView.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 16.01.2018.
//  Copyright © 2018 pkuzia. All rights reserved.
//

import UIKit

class RouteOptionsView: UIView {

    // MARK: - Outlets

    @IBOutlet weak var startAddress: UILabel!
    @IBOutlet weak var endAddress: UILabel!
    
    @IBOutlet weak var freeRouteOption: UIButton!
    @IBOutlet weak var optimalRouteOption: UIButton!
    @IBOutlet weak var fastestRouteOption: UIButton!
    
    // MARK: - Appearance
    
    func initView(startAddressText: String, endAddressText: String) {
        freeRouteOption.layer.cornerRadius = freeRouteOption.frame.width / 2
        freeRouteOption.backgroundColor = UIColor.white
        freeRouteOption.tintColor = StyleKit.colorType(color: .baseGreenColor)
        freeRouteOption.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        optimalRouteOption.layer.cornerRadius = freeRouteOption.frame.width / 2
        optimalRouteOption.backgroundColor = UIColor.white
        optimalRouteOption.tintColor = StyleKit.colorType(color: .baseGreenColor)
        optimalRouteOption.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        fastestRouteOption.layer.cornerRadius = freeRouteOption.frame.width / 2
        fastestRouteOption.backgroundColor = UIColor.white
        fastestRouteOption.tintColor = StyleKit.colorType(color: .baseGreenColor)
        fastestRouteOption.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        startAddress.attributedText = StyleKit.attributedText(text: startAddressText, attribute: .naviDetailsAddress)
        endAddress.attributedText = StyleKit.attributedText(text: endAddressText, attribute: .naviDetailsAddress)
//        freeRouteOption.isHighlighted = true
    }
    
    func setActiveButton(type: RouteType) {
        unselectAllButtons()
//        switch type {
//        case .fastest:
//            fastestRouteOption.isHighlighted = true
//        case .free:
//            freeRouteOption.isHighlighted = true
//        case .optimal:
//            optimalRouteOption.isHighlighted = true
//        }
    }
    
    fileprivate func unselectAllButtons() {
        fastestRouteOption.isHighlighted = false
        optimalRouteOption.isHighlighted = false
        fastestRouteOption.isHighlighted = false
    }
}
