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
    
    var camera: GMSCameraPosition?
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
    
    func initUI() {
        startPointTextField.placeholder = navigationViewModel.startPointPlaceholder
        endPointTextField.placeholder = navigationViewModel.endPointPlaceholder
        startPointTextField.delegate = self
        endPointTextField.delegate = self
        
        navigationViewModel.navigationRoute(startPoint: Point(lat: 52.250771, lng: 20.845112),
                                            endPoint: Point(lat: 52.231290, lng: 20.956922)) { result in
                                                self.initMapView()
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
    
    // MARK: - Additional Helpers
    
    fileprivate func initMapView() {
        camera = GMSCameraPosition.camera(withLatitude: 52.2507986,
                                              longitude: 20.8451497,
                                              zoom: 14)
        if let camera = camera {
            mapView.camera = camera
        }
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

