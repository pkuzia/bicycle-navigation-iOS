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
    
    let navigationService = NavigationService()
    
    weak var delegate: NavigationViewModelDelegate?
    
    var routeResponse: RouteResponse?
    
    // MARK: - Functions
    
    func navigationRoute(startPoint: Point, endPoint: Point, completionHandler: @escaping (FetchResult) -> ()) {
        let routeRequest = RouteRequest(startPoint: startPoint, endPoint: endPoint)
        navigationService.routes(routeRequest: routeRequest) { result, routeResponse in
            DispatchQueue.main.async {
                if result.error != nil {
                    completionHandler(result)
                } else {
                    if let routeResponse = routeResponse {
                        self.routeResponse = routeResponse
                        completionHandler(FetchResult(error: nil))
                    } else {
                        completionHandler(FetchResult(error: .unknownError))
                    }
                }
            }
        }
    }
}


