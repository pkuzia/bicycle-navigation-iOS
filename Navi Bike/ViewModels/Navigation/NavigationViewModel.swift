//
//  NavigationViewModel.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 28.12.2017.
//Copyright © 2017 pkuzia. All rights reserved.
//

import UIKit
import GoogleMaps

protocol NavigationViewModelDelegate: class {
    
}

enum MarkerType {
    case start, end
}

enum NavigationUIState {
    case search, navi
}

class NavigationViewModel: BaseViewModel {
    
    // MARK: - Strings
    
    let startPointPlaceholder = "start_point_placeholder".localized
    let endPointPlaceholder = "end_point_placeholder".localized
    
    let geocodeSpinnerInfo = "geocode_spinner".localized
    let naviSpinnerInfo = "navi_spinner".localized
    
    // MARK: - View Model Data
    
    let navigationService = NavigationService()
    
    weak var delegate: NavigationViewModelDelegate?
    
    var routeResponse: RouteResponse?
    var startPointGeocode: GeocodeResponse?
    var endPointGeocode: GeocodeResponse?
    var currentStep = 0
    
    // MARK: - Functions
    
    func getGeocodePoint(type: MarkerType) -> CLLocationCoordinate2D? {
        switch type {
        case .start:
            if let lat = startPointGeocode?.lat, let lng = startPointGeocode?.lng {
                return CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
            }
        case .end:
            if let lat = endPointGeocode?.lat, let lng = endPointGeocode?.lng {
                return CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
            }
        }
        return nil
    }
    
    func getAPIPoint(type: MarkerType) -> Point? {
        switch type {
        case .start:
            if let lat = startPointGeocode?.lat, let lng = startPointGeocode?.lng {
                return Point(lat: lat, lng: lng)
            }
        case .end:
            if let lat = endPointGeocode?.lat, let lng = endPointGeocode?.lng {
                return Point(lat: lat, lng: lng)
            }
        }
        return nil
    }
    
    func getLocationCurrentStepEndPoint() -> CLLocation? {
        if let currentStepObject = routeResponse?.routes?.steps?.item(at: currentStep), let lat = currentStepObject.endPoint?.lat,
            let lng = currentStepObject.endPoint?.lng {
            return CLLocation(latitude: lat, longitude: lng)
        }
        return nil
    }
    
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
    
    func geocode(address: String, startPoint: Bool, completionHandler: @escaping (FetchResult) -> ()) {
        let geocodeRequest = GeocodeRequest(address: address)
        navigationService.geocode(geocodeRequest: geocodeRequest) { result, geocodeResponse in
            DispatchQueue.main.async {
                if result.error != nil {
                    completionHandler(result)
                } else {
                    if let geocodeResponse = geocodeResponse {
                        if startPoint {
                            self.startPointGeocode = geocodeResponse
                        } else {
                            self.endPointGeocode = geocodeResponse
                        }
                        completionHandler(FetchResult(error: nil))
                    } else {
                        completionHandler(FetchResult(error: .unknownError))
                    }
                }
            }
        }
    }
}
