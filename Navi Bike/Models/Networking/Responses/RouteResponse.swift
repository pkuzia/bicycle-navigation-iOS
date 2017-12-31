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
    var routes: Route?
    
    override public func mapping(map: Map) {
        polyline <- map["routes.0.overview_polyline.points"]
        routes <- map["routes.0.legs.0"]
    }
}

class Route: BaseResponse {
    
    var distance: String?
    var duration: String?
    
    var endPointAddress: String?
    var endPoint: GooglePoint?
    
    var startPointAddress: String?
    var startPoint: GooglePoint?
    
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
    
    var endPoint: GooglePoint?
    var startPoint: GooglePoint?
    
    var instructions: String?
    
    override public func mapping(map: Map) {
        distance <- map["distance.text"]
        duration <- map["duration.text"]
        
        endPoint   <- map["end_location"]
        startPoint <- map["start_location"]
        
        instructions <- map["html_instructions"]
    }
}

class GooglePoint: BaseResponse {
    
    var lat: Float?
    var lng: Float?

    override public func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}
