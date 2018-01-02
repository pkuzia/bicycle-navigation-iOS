//
//  GeocodeRequest.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 28.12.2017.
//  Copyright © 2017 pkuzia. All rights reserved.
//

public class GeocodeRequest: BaseRequest {
    
    var address: String?
    
    init(address: String) {
        self.address = address
    }
    
    fileprivate func getParametersBody() -> [String: Any]? {
        return nil
    }
    
    fileprivate func getParametersQuery() -> [String: Any]? {
        var parameters = [String: Any]()
        parameters["address"] = address
        parameters["key"] = geocodeKey
        return parameters
    }
    
    public func getParameters() -> [String: Any]? {
        var parameters: [String: Any] = [:]
        parameters[queryName] = getParametersQuery()
        parameters[bodyName] = getParametersBody()
        return parameters
    }
    
}
