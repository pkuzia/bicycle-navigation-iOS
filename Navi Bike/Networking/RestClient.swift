//
//  RestClient.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 12/28/17
//  Copyright (c) 2017 pkuzia. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

let googleMapsProvider = MoyaProvider<RestClient>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum RestClient {
    case route(RouteRequest)
}

extension RestClient: TargetType {
    public var baseURL: URL { return URL(string: "https://maps.googleapis.com/maps/api/directions/json")! }
    
    public var path: String {
        switch self {
        case .route:
            return "?origin=Disneyland&destination=Universal+Studios+Hollywood4&key=AIzaSyBM6cgLuiiHUVC9OIIUB7PcWy9jp5dj_TQ"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .route(_):
            return [:]
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var task: Task {
        return .request
    }
    
    public var validate: Bool {
        switch self {
        case .route:
            return true
        }
    }
    
    public var sampleData: Data {
        return "Sample Data.".data(using: String.Encoding.utf8)!
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
