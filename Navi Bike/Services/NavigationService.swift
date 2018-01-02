//
//  NavigationService.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 28.12.2017.
//  Copyright © 2017 pkuzia. All rights reserved.
//

import Foundation

class NavigationService: BaseService {
 
    func routes(routeRequest: RouteRequest, completionHandler: @escaping (FetchResult, RouteResponse?) -> ()) {
        googleMapsProvider.request(.route(routeRequest)) { result in
            self.handleMoyaResultWithMappingObject(result: result, completionHandler: completionHandler)
        }
    }
    
    func geocode(geocodeRequest: GeocodeRequest, completionHandler: @escaping (FetchResult, GeocodeResponse?) -> ()) {
        googleMapsProvider.request(.geocode(geocodeRequest)) { result in
            self.handleMoyaResultWithMappingObject(result: result, completionHandler: completionHandler)
        }
    }
}
