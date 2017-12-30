//
//  RouteResponse.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 29.12.2017.
//  Copyright © 2017 pkuzia. All rights reserved.
//

import Foundation
import ObjectMapper

class RouteResponse: BaseResponse {
    
    var polyline: String?
    var route: Route?
    
    override public func mapping(map: Map) {
        polyline <- map["overview_polyline.points"]
        route <- map["legs.0"]
    }
}

class Route: BaseResponse {
    
    var distance: String?
    var duration: String?
    
    var endPointAddress: String?
    var endPoint: Point?
    
    var startPointAddress: String?
    var startPoint: Point?
    
    var steps: [Step]?
    
    override public func mapping(map: Map) {
        distance <- map["distance.text"]
        duration <- map["duration.text"]
        
        endPoint        <- map["end_location"]
        endPointAddress <- map["end_address"]
        
        startPoint        <- map["start_location"]
        startPointAddress <- map["start_address"]
        
        steps <- map["steps"]
    }
}

class Step: BaseResponse {
    
    var distance: String?
    var duration: String?
    
    var endPoint: Point?
    var startPoint: Point?
    
    var instructions: String?
    
    override public func mapping(map: Map) {
        distance <- map["distance.text"]
        duration <- map["duration.text"]
        
        endPoint   <- map["end_location"]
        startPoint <- map["start_location"]
        
        instructions <- map["html_instructions"]
    }
}
