//
//  RestuarantCollectionViewCell.swift
//  BottleRocket
//
//  Created by Ethan Perkins on 12/15/21.
//

import UIKit

class RestuarantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    
    var restaurant: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let restaurant = restaurant else { return }
        restaurantNameLabel.text = restaurant.name
        restaurantCategoryLabel.text = restaurant.category
        
        restaurantImageView.contentMode = .scaleAspectFill
        
        LunchController.fetchRestaurantImage(restaurant: restaurant) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let image):
                    self.restaurantImageView.image = image
                case .failure(let error):
                    self.restaurantImageView.image = UIImage(systemName: "photo.on.rectangle")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
