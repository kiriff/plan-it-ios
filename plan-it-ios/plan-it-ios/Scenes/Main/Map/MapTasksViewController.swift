//
//  CalendarViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/5/19.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacesSearchController

class MapTasksViewController: UIViewController {
    
    var cameFromDetails = false
    var completion: ((Address) -> ())? = nil
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if completion == nil {
            HUD.show()
            APIManager.shared.getListTasks(successBlock: { [weak self] (tasks) in
                HUD.hide()
                self?.mapView.clear()
                tasks.forEach { [weak self] (task) in
                    if let address = task.address, address.lat != 0 && address.lon != 0 {
                        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: address.lat, longitude: address.lon))
                        marker.snippet = address.name
                        marker.map = self?.mapView
                        marker.title = task.name
                        marker.userData = task
                    }
                }
            })
            
        }
    }

    private func initialSetup() {
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        // Create a map.
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we&#39;ve got a location update.
        view.addSubview(mapView)
        mapView.isHidden = true
        mapView.delegate = self
        
    }
}

// Delegates to handle events for the location manager.
extension MapTasksViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

extension MapTasksViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        print("Coordinates: ", coordinate)
        let geocoder = GMSGeocoder()
        var address = ""
        if let completion = self.completion {
            HUD.show()
            geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
                address = response?.results()?.first?.lines?.first ?? "Address not found"
                print(address)
                let a = Address(name: address, lat: coordinate.latitude, lon: coordinate.longitude)
                HUD.hide()
                self.dismiss(animated: true) {
                    completion(a)
                }
            }
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let task = marker.userData as? Task {
            self.presentAsStork(TaskDetailsViewController.storyboardController(task: task, completion: { (task) in
                APIManager.shared.updateTask(task)
            }))
        }
    }
}
