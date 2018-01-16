//
//  RouteRequest.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 28.12.2017.
//  Copyright © 2017 pkuzia. All rights reserved.
//

import Foundation

struct Point {
    var latitude: Double
    var longitude: Double
    
    init(lat: Double, lng: Double) {
        self.latitude = lat
        self.longitude = lng
    }
    
    func toRequest() -> [String: Any]? {
        var parameters = [String: Any]()
        parameters["latitude"] = latitude
        parameters["longitude"] = longitude
        return parameters
    }
}

public class RouteRequest: BaseRequest {
    
    var startPoint: Point
    var endPoint: Point
    
    init(startPoint: Point, endPoint: Point) {
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    fileprivate func getParametersBody() -> [String: Any]? {
        var parameters = [String: Any]()
        parameters["start"] = startPoint.toRequest()
        parameters["destination"] = endPoint.toRequest()
        return parameters
    }
    
    fileprivate func getParametersQuery() -> [String: Any]? {
        return nil
    }
    
    public func getParameters() -> [String: Any]? {
        var parameters: [String: Any] = [:]
        parameters[queryName] = getParametersQuery()
        parameters[bodyName] = getParametersBody()
        return parameters
    }
    
}
