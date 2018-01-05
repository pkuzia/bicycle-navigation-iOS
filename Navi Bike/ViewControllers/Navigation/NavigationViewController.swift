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

class NavigationViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var startPointTextField: UITextField!
    @IBOutlet weak var endPointTextField: UITextField!
    @IBOutlet weak var naviButton: UIButton!
    
    @IBOutlet weak var bottomRouteView: UIView!
    @IBOutlet weak var currentHint: UILabel!
    @IBOutlet weak var nextHint: UILabel!
    
    var camera: GMSCameraPosition?
    let locationManager = CLLocationManager()
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
        startPointTextField.placeholder = navigationViewModel.startPointPlaceholder
        endPointTextField.placeholder = navigationViewModel.endPointPlaceholder
        startPointTextField.delegate = self
        endPointTextField.delegate = self
        
        naviButton.layer.cornerRadius = naviButton.frame.width / 2
        naviButton.backgroundColor = StyleKit.colorType(color: .baseGreenColor)
        
        bottomRouteView.alpha = 0
        
        mockFunc()
    }
    
    fileprivate func mockFunc() {
        startPointTextField.text = "Stare Babice, Graniczna 25"
        endPointTextField.text = "Politechnika Warszawska"
        
        navigationViewModel.geocode(address: startPointTextField.text!, startPoint: true, completionHandler: { result in
            SwiftSpinner.hide()
            self.addMarkerToMap(type: .start)
        })
        
        navigationViewModel.geocode(address: endPointTextField.text!, startPoint: false, completionHandler: { result in
            SwiftSpinner.hide()
            self.addMarkerToMap(type: .end)
        })
    }
    
    fileprivate func changeUI(state: NavigationUIState) {
        UIView.animate(withDuration: 1.0) {
            switch state {
            case .navi:
                self.bottomRouteView.alpha = 1.0
                self.naviButton.alpha = 0.0
            case .search:
                self.bottomRouteView.alpha = 0.0
                self.naviButton.alpha = 1.0
            }
        }
    }
    
    fileprivate func updateBottomRouteView() {
        if let currentHintValue = navigationViewModel.routeResponse?.routes?.steps?.item(at: navigationViewModel.currentStep)?.instructions {
            currentHint.attributedText = StyleKit.attributedText(text: currentHintValue, attribute: .currentHintLabel)
        }
        
        if let nextHintValue = navigationViewModel.routeResponse?.routes?.steps?.item(at: navigationViewModel.currentStep + 1)?.instructions {
            nextHint.attributedText = StyleKit.attributedText(text: nextHintValue, attribute: .nextHintLabel)
        }
    }
    
    // MARK: - User Interaction
    
    @IBAction func startPointSearch(_ sender: Any) {
        if let startPointAddress = startPointTextField.text {
            SwiftSpinner.show(navigationViewModel.geocodeSpinnerInfo, animated: true)
            navigationViewModel.geocode(address: startPointAddress, startPoint: true, completionHandler: { result in
                SwiftSpinner.hide()
                self.addMarkerToMap(type: .start)
            })
        }
    }
    
    @IBAction func endPointSeach(_ sender: Any) {
        if let endPointAddress = endPointTextField.text {
            SwiftSpinner.show(navigationViewModel.geocodeSpinnerInfo, animated: true)
            navigationViewModel.geocode(address: endPointAddress, startPoint: false, completionHandler: { result in
                SwiftSpinner.hide()
                self.addMarkerToMap(type: .end)
            })
        }
    }
    
    @IBAction func naviButtonClickHandler(_ sender: Any) {
        if let startPoint = navigationViewModel.getAPIPoint(type: .start), let endPoint = navigationViewModel.getAPIPoint(type: .end) {
            SwiftSpinner.show(navigationViewModel.naviSpinnerInfo)
            navigationViewModel.navigationRoute(startPoint: startPoint, endPoint: endPoint, completionHandler: { _ in
                SwiftSpinner.hide()
                self.showRouteOnMap()
            })
        }
    }
    
    // MARK: - Additional Helpers
    
    fileprivate func showRouteOnMap() {
        guard let path = navigationViewModel.routeResponse?.polyline,
            let markerPosition = navigationViewModel.getGeocodePoint(type: .start) else {
            return
        }
        let poliline = GMSPolyline(path: GMSPath(fromEncodedPath: path))
        poliline.map = mapView
        poliline.strokeColor = StyleKit.colorType(color: .baseGreenColor)
        poliline.strokeWidth = 3
        mapView.animate(to: GMSCameraPosition(target: markerPosition, zoom: 15, bearing: 0, viewingAngle: 0))
        changeUI(state: .navi)
        updateBottomRouteView()
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
        
        mapView.animate(to: GMSCameraPosition(target: markerPosition, zoom: 15, bearing: 0, viewingAngle: 0))
    }
}

// MARK: - NavigationViewModelDelegate

extension NavigationViewController: NavigationViewModelDelegate {
    
}

// MARK: - NavigationViewModelDelegate

extension NavigationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NavigationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentStepEndPointLocation = navigationViewModel.getLocationCurrentStepEndPoint() {
            print(locations.item(at: 0)?.distance(from: currentStepEndPointLocation))
        }
    }
}

