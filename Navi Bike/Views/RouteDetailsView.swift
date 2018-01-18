//
//  RouteDetailsView.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 16.01.2018.
//  Copyright © 2018 pkuzia. All rights reserved.
//

import UIKit

class RouteDetailsView: UIView {

    // MARK: - Outlets
    
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var timeValue: UILabel!
    
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    
    @IBOutlet weak var distanceTitle: UILabel!
    @IBOutlet weak var distanceValue: UILabel!
    
    let routeDetailsViewModel = RouteDetailsViewModel()
    
    // MARK: - Appearance
    
    func initView() {
        timeTitle.attributedText = StyleKit.attributedText(text: routeDetailsViewModel.timeLabelTitle,
                                                           attribute: .routeDetailsTitle)
        priceTitle.attributedText = StyleKit.attributedText(text: routeDetailsViewModel.priceLabelTitle,
                                                           attribute: .routeDetailsTitle)
        distanceTitle.attributedText = StyleKit.attributedText(text: routeDetailsViewModel.distanceLabelTitle,
                                                           attribute: .routeDetailsTitle)
        guard let route = routeDetailsViewModel.route else {
            return
        }
        
        if let duration = routeDetailsViewModel.route?.duration {
            timeValue.attributedText = StyleKit.attributedText(text: duration, attribute: .routeDetailsValue)
        }
        
        if let price = routeDetailsViewModel.route?.price {
            priceValue.attributedText = StyleKit.attributedText(text: price, attribute: .routeDetailsValue)
        }
        
        if let distance = routeDetailsViewModel.route?.distance {
            distanceValue.attributedText = StyleKit.attributedText(text: distance, attribute: .routeDetailsValue)
        }
    }
    
    // MARK: - User Interaction
    
}
