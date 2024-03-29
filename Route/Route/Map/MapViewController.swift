//
//  MapViewController.swift
//  Route
//
//  Created by Pamella Lima on 24/03/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    let locationManager = CLLocationManager()
    
    //MARK: - Layout
    
    private lazy var mapView : MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
        return map
    }()
    
    //MARK: - Variables
    
    let scale: CGFloat = 300
    var mapItems: [MKMapItem]? = []
    let centerCoordinate = CLLocationCoordinate2D(latitude: -7.1195, longitude: -34.8450)
    let radius: CLLocationDistance = 10000
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthorization() 
        setMapConstraints()
        view.backgroundColor = .yellow
        locationManager.delegate = self
        addMapAnnotations()
        zoomToRegion(centerCoordinate: centerCoordinate, radius: radius)
    }
    
    //MARK: - Functions
    
    private func zoomToRegion(centerCoordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //    private func getLocationDistance(location: MKMapItem) -> Double? {
    //        guard let userLocation else { return nil }
    //        let location = location.placemark.location?.distance(from: userLocation)
    //        return location
    //    }
    
    private func addMapAnnotations() {
        let coordinate = CLLocationCoordinate2DMake(-7.099773, -34.844334)
        let item = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        item.name = "Manaíra Shopping"
        item.phoneNumber = "51 3333.2222"
        
        let coordinate2 = CLLocationCoordinate2DMake(-7.115777, -34.884659)
        let item2 = MKMapItem(placemark: MKPlacemark(coordinate: coordinate2))
        item2.name = "Trauma"
        item2.phoneNumber = "51 3333.2222"
        
        mapItems?.append(item)
        mapItems?.append(item2)
        
        print("count \(mapItems?.count)")
        
        guard let mapItems else {return}
        for item in mapItems {
            let annotation = MKPointAnnotation()
            annotation.coordinate = item.placemark.coordinate
            annotation.title = item.name
            annotation.subtitle = item.phoneNumber
            let range = 1000
            self.mapView.addAnnotation(annotation)
        }
    }
    
    //MARK: - Constraints
    
    private func setMapConstraints() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate { }

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // centerViewOnUserLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
        print(manager)
    }
    
    // adicionar o filtro
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
        print(view.annotation?.subtitle)
    }
}

