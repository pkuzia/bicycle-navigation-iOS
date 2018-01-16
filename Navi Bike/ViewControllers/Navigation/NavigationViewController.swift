//
//  NavigationViewController.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 28.12.2017.
//Copyright © 2017 pkuzia. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftSpinner
import AVFoundation

enum TopViewState {
    case search, navigationDetails
}

enum BottomViewState {
    case routeDetails, hintsDetails, empty
}

class NavigationViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var routeOptionsView: RouteOptionsView!
    @IBOutlet weak var hintsView: HintsView!
    @IBOutlet weak var routeDetailsView: RouteDetailsView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var startNaviButton: UIButton!
    
    var camera: GMSCameraPosition?
    let locationManager = CLLocationManager()
    let speechSynthesizer = AVSpeechSynthesizer()
    let navigationViewModel = NavigationViewModel()
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    // MARK: - Appearance
    
    fileprivate func initUI() {
        initMapView()
        setTopView(to: .search)
        setBottomView(to: .empty)
        
        mockFunc()
    }
    
    fileprivate func setBottomView(to state: BottomViewState) {
        switch state {
        case .empty:
            hintsView.alpha = 0.0
            routeDetailsView.alpha = 0.0
        case .hintsDetails:
            hintsView.alpha = 1.0
            routeDetailsView.alpha = 0.0
            startNaviButton.alpha = 0.0
        case .routeDetails:
            routeDetailsView.routeDetailsViewModel.route = navigationViewModel.getSelectedRoute()
            routeDetailsView.initView()
            hintsView.alpha = 0.0
            routeDetailsView.alpha = 1.0
        }
    }
    
    fileprivate func setTopView(to state: TopViewState) {
        switch state {
        case .navigationDetails:
            searchView.alpha = 0.0
            searchButton.alpha = 0.0
            startNaviButton.alpha = 1.0
            routeOptionsView.alpha = 1.0
            if let startPointAddress = searchView.startPointTextField.text, let endPointAddress = searchView.endPointTextField.text  {
                routeOptionsView.initView(startAddressText: startPointAddress, endAddressText: endPointAddress)
            }
        case .search:
            routeOptionsView.alpha = 0.0
            searchView.alpha = 1.0
            searchButton.alpha = 1.0
            startNaviButton.alpha = 0.0
            searchView.resetTextFields()
        }
    }
    
    fileprivate func mockFunc() {
        searchView.startPointTextField.text = "Człuchowska 25, Warszawa"
        searchView.endPointTextField.text = "Nowowiejska 15/19, Warszawa"

        navigationViewModel.geocode(address: searchView.startPointTextField.text!, startPoint: true, completionHandler: { result in
            SwiftSpinner.hide()
            self.addMarkerToMap(type: .start)
        })

        navigationViewModel.geocode(address: searchView.endPointTextField.text!, startPoint: false, completionHandler: { result in
            SwiftSpinner.hide()
            self.addMarkerToMap(type: .end)
        })
    }

    fileprivate func changeUI(state: NavigationUIState) {
        UIView.animate(withDuration: 1.0) {
            switch state {
            case .navi:
                self.setTopView(to: .navigationDetails)
                self.setBottomView(to: .hintsDetails)
            case .routeOptions:
                self.setTopView(to: .navigationDetails)
                self.setBottomView(to: .routeDetails)
            case .search:
                self.setTopView(to: .search)
                self.setBottomView(to: .empty)
            }
        }
    }
    
    fileprivate func updateHintsView() {
        guard let selectedRoute = navigationViewModel.getSelectedRoute() else {
            return
        }
        if let currentHintValue = selectedRoute.steps?.item(at: navigationViewModel.currentStep)?.instructions,
            let nextHintValue = selectedRoute.steps?.item(at: navigationViewModel.currentStep + 1)?.instructions{
            hintsView.setHints(current: currentHintValue, next: nextHintValue)
        }
    }
    
    // MARK: - User Interaction
    
    @IBAction func startPointSearch(_ sender: Any) {
        if let startPointAddress = searchView.startPointTextField.text {
            SwiftSpinner.show(navigationViewModel.geocodeSpinnerInfo, animated: true)
            navigationViewModel.geocode(address: startPointAddress, startPoint: true, completionHandler: { result in
                SwiftSpinner.hide()
                self.addMarkerToMap(type: .start)
            })
        }
    }
    
    @IBAction func endPointSeach(_ sender: Any) {
        if let endPointAddress = searchView.endPointTextField.text {
            SwiftSpinner.show(navigationViewModel.geocodeSpinnerInfo, animated: true)
            navigationViewModel.geocode(address: endPointAddress, startPoint: false, completionHandler: { result in
                SwiftSpinner.hide()
                self.addMarkerToMap(type: .end)
            })
        }
    }
    @IBAction func closeButtonClick(_ sender: Any) {
    }
    
    @IBAction func freeRouteOptionClick(_ sender: Any) {
        navigationViewModel.selectedRoute = .free
        routeOptionsView.setActiveButton(type: .free)
        optionButtonChanged()
    }
    
    @IBAction func optimalRouteOptionClick(_ sender: Any) {
        navigationViewModel.selectedRoute = .optimal
        routeOptionsView.setActiveButton(type: .optimal)
        optionButtonChanged()
    }

    @IBAction func fastestRouteOptionClick(_ sender: Any) {
        navigationViewModel.selectedRoute = .fastest
        routeOptionsView.setActiveButton(type: .fastest)
        optionButtonChanged()
    }
    
    @IBAction func startNaviButtonClick(_ sender: Any) {
        setBottomView(to: .hintsDetails)
        startNavigation()
    }
    
    @IBAction func searchButtonClickHandler(_ sender: Any) {
        if let startPoint = navigationViewModel.getAPIPoint(type: .start), let endPoint = navigationViewModel.getAPIPoint(type: .end) {
            SwiftSpinner.show(navigationViewModel.naviSpinnerInfo)
            navigationViewModel.navigationRoute(startPoint: startPoint, endPoint: endPoint, completionHandler: { _ in
                SwiftSpinner.hide()
                self.routeOptionsView.setActiveButton(type: self.navigationViewModel.selectedRoute)
                self.setTopView(to: .navigationDetails)
                self.setBottomView(to: .routeDetails)
                self.showRouteOnMap()
            })
        }
//        let speechUtterance = AVSpeechUtterance(string: "Przemi is the best and notorious gansgter in the world")
//        speechSynthesizer.speak(speechUtterance)
    }
    
    // MARK: - Additional Helpers
    
    fileprivate func optionButtonChanged() {
        showRouteOnMap()
        setBottomView(to: .routeDetails)
    }
    
    fileprivate func startNavigation() {
        if let startMarker = navigationViewModel.mapViewMarkers.item(at: 0) {
            mapView.animate(to: GMSCameraPosition(target: startMarker.position, zoom: 15, bearing: 0, viewingAngle: 0))
        }
        navigationViewModel.currentStep = 0
        updateHintsView()
    }
    
    fileprivate func showRouteOnMap() {
        guard let route = navigationViewModel.getSelectedRoute(), let path = route.poliline else {
            return
        }
        mapView.clear()
        let poliline = GMSPolyline(path: GMSPath(fromEncodedPath: path))
        poliline.map = mapView
        poliline.strokeColor = StyleKit.colorType(color: .baseGreenColor)
        poliline.strokeWidth = 3
        addRouteMarkersToMap()
    }
    
    fileprivate func initMapView() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        camera = GMSCameraPosition.camera(withLatitude: 52.2507986,
                                              longitude: 20.8451497,
                                              zoom: 14)
        if let camera = camera {
            mapView.camera = camera
        }
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
        
        searchButton.layer.cornerRadius = searchButton.frame.width / 2
        searchButton.backgroundColor = StyleKit.colorType(color: .baseGreenColor)
        startNaviButton.layer.cornerRadius = searchButton.frame.width / 2
        startNaviButton.backgroundColor = StyleKit.colorType(color: .baseGreenColor)
        startNaviButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 17, bottom: 17, right: 17)
    }
    
    fileprivate func addRouteMarkersToMap() {
        let startMarker = GMSMarker()
        let endMarker = GMSMarker()
        
        guard let markerPositions = navigationViewModel.getRoutePoints() else {
            return
        }
        navigationViewModel.mapViewMarkers.removeAll()
        startMarker.position = markerPositions.0
        endMarker.position = markerPositions.1
        
        startMarker.map = mapView
        endMarker.map = mapView
        
        var bounds = GMSCoordinateBounds()
        for marker in [startMarker, endMarker] {
            bounds = bounds.includingCoordinate(marker.position)
            navigationViewModel.mapViewMarkers.append(marker)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        mapView.animate(with: update)
    }
    
    fileprivate func addMarkerToMap(type: MarkerType) {
        let marker = GMSMarker()
        marker.appearAnimation = .pop
        
        switch type {
        case .start:
            marker.snippet = navigationViewModel.startPointPlaceholder
        case .end:
            marker.snippet = navigationViewModel.endPointPlaceholder
        }
        guard let markerPosition = navigationViewModel.getGeocodePoint(type: type) else {
            return
        }
        marker.position = markerPosition
        marker.map = mapView
        navigationViewModel.mapViewMarkers.append(marker)
        
        mapView.animate(to: GMSCameraPosition(target: markerPosition, zoom: 15, bearing: 0, viewingAngle: 0))
    }
}

// MARK: - NavigationViewModelDelegate

extension NavigationViewController: NavigationViewModelDelegate {
    
}

extension NavigationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let minDistance = 5.0
        if let currentStepEndPointLocation = navigationViewModel.getLocationCurrentStepStartPoint() {
            print((locations.item(at: 0)?.distance(from: currentStepEndPointLocation))!)
    
            if let distance = locations.item(at: 0)?.distance(from: currentStepEndPointLocation),
                distance < minDistance {
                navigationViewModel.currentStep += 1
                updateHintsView()
            }
        }
    }
}

