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
    
    var optimalRoute: Route?
    var fastestRoute: Route?
    var freeRoute: Route?
    
    override public func mapping(map: Map) {
        optimalRoute <- map["optimal"]
        fastestRoute <- map["fastest"]
        freeRoute <- map["free"]
    }
}

class Route: BaseResponse {
    
    var poliline: String?
    
    var distance: String?
    var duration: String?
    
    var endPointAddress: String?
    var endPoint: GooglePoint?
    
    var startPointAddress: String?
    var startPoint: GooglePoint?
    
    var steps: [Step]?
    
    override public func mapping(map: Map) {
        poliline <- map["polyline"]
        
        distance <- map["route.distance"]
        duration <- map["route.duration"]
        
        endPoint        <- map["route.endPoint"]
        endPointAddress <- map["route.endPointAddress"]
        
        startPoint        <- map["route.startPoint"]
        startPointAddress <- map["route.startPointAddress"]
        
        steps <- map["route.steps"]
    }
}

class Step: BaseResponse {
    
    var distance: String?
    var duration: String?
    
    var endPoint: GooglePoint?
    var startPoint: GooglePoint?
    
    var instructions: String?
    
    override public func mapping(map: Map) {
        distance <- map["distance"]
        duration <- map["duration"]
        
        endPoint   <- map["endPoint"]
        startPoint <- map["startPoint"]
        
        instructions <- map["instructions"]
    }
}

class GooglePoint: BaseResponse {
    
    var lat: Double?
    var lng: Double?
    
    override public func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}
