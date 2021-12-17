//
//  MapViewController.swift
//  BottleRocket
//
//  Created by Ethan Perkins on 12/16/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var restaurants: [Restaurant]?
        
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAnnotations()
        
    }
    
    func createAnnotations() {
        
        print(restaurants?.count ?? 0)
        guard let restaurants = restaurants else { return }
        var annotations: [MKAnnotation] = []
        var currentCoordinate = CLLocationCoordinate2D()
        
        for restaurant in restaurants {
            
            guard let latitude = CLLocationDegrees(exactly: restaurant.location.lat),
                  let longitude = CLLocationDegrees(exactly: restaurant.location.lng) else { return }
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            currentCoordinate = coordinate
            let annotation = MKPointAnnotation()
            annotation.title = restaurant.name
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        
        mapView.showAnnotations(annotations, animated: true)
        mapView.setRegion(MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: 8000, longitudinalMeters: 8000), animated: true)
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}


