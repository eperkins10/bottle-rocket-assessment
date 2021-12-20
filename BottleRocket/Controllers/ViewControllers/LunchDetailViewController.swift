//
//  LunchDetailViewController.swift
//  BottleRocket
//
//  Created by Ethan Perkins on 12/15/21.
//

import UIKit
import MapKit

class LunchDetailViewController: UIViewController {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var restaurantStreetName: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantPhoneLabel: UILabel!
    @IBOutlet weak var restaurantTwitterLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let restaurant = restaurant else { return }
        
        guard let latitude = CLLocationDegrees(exactly: restaurant.location.lat),
              let longitude = CLLocationDegrees(exactly: restaurant.location.lng) else { return }
        
        DispatchQueue.main.async {
            let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let mapAnnotation = MKPointAnnotation()
            mapAnnotation.title = restaurant.name
            mapAnnotation.coordinate = coordinates
            self.mapView.setRegion(MKCoordinateRegion(center: coordinates, latitudinalMeters: 6000, longitudinalMeters: 6000), animated: true)
            self.mapView.showAnnotations([mapAnnotation], animated: true)
            self.restaurantNameLabel.text = restaurant.name
            self.restaurantCategoryLabel.text = restaurant.category
            self.restaurantStreetName.text = restaurant.location.address
            self.restaurantAddressLabel.text = restaurant.location.formattedAddress[1]
            
            if let phone = restaurant.contact?.formattedPhone {
                self.restaurantPhoneLabel.text = phone
            } else {
                self.restaurantPhoneLabel.text = "No phone number available"
            }
            
            if let twitter = restaurant.contact?.twitter {
                self.restaurantTwitterLabel.text = "@\(twitter)"
            } else {
                self.restaurantTwitterLabel.text = "No twitter available"
            }
        }
    }
}
