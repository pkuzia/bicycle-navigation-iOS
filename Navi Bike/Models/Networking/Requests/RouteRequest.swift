//
//  RouteRequest.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 28.12.2017.
//  Copyright © 2017 pkuzia. All rights reserved.
//

import Foundation

struct Point {
    var lat: Float
    var lng: Float
    
    init(lat: Float, lng: Float) {
        self.lat = lat
        self.lng = lng
    }
    
    func convertToRequest() -> String {
        return "\(lat), \(lng)"
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
        return nil
    }
    
    fileprivate func getParametersQuery() -> [String: Any]? {
        var parameters = [String: Any]()
        parameters["origin"] = startPoint.convertToRequest()
        parameters["destination"] = endPoint.convertToRequest()
        parameters["key"] = directionsKey
        return parameters
    }
    
    public func getParameters() -> [String: Any]? {
        var parameters: [String: Any] = [:]
        parameters[queryName] = getParametersQuery()
        parameters[bodyName] = getParametersBody()
        return parameters
    }
    
}
