//
//  Lunch.swift
//  BottleRocket
//
//  Created by Ethan Perkins on 12/15/21.
//

import Foundation
import CoreLocation

    struct Lunch: Decodable {
    
        let restaurants: [Restaurant]
    
    }
    
    struct Restaurant: Decodable {
        
        let name: String
        let backgroundImageURL: String
        let category: String
        
        let contact: Contact?
        let location: Location
        
    }
    
    struct Location: Decodable {
        let address: String
        let crossStreet: String?
        let lat: Double
        let lng: Double
        let postalCode: String?
        let city: String
        let state: String
    
        let formattedAddress: [String]
    
    }

    struct Contact: Decodable {
        let formattedPhone: String?
        let twitter: String?
    }


