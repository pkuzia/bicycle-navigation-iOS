//
//  GeocodeResponse.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 29.12.2017.
//  Copyright © 2017 pkuzia. All rights reserved.
//

import Foundation
import ObjectMapper

class GeocodeResponse: BaseResponse {
    
    var lat: Double?
    var lng: Double?
    
    override public func mapping(map: Map) {
        lat <- map["results.0.geometry.location.lat"]
        lng <- map["results.0.geometry.location.lng"]
    }
}
