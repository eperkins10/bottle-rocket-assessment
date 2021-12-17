//
//  LunchCollectionViewController.swift
//  BottleRocket
//
//  Created by Ethan Perkins on 12/15/21.
//

import UIKit

private let reuseIdentifier = "restaurantCell"

class LunchCollectionViewController: UICollectionViewController {
    
    var restaurants: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchRestaurants()
    }
    
    func fetchRestaurants() {
        LunchController.fetchRestaurants { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let restaurants):
                    self.restaurants = restaurants
                    self.collectionView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destination = segue.destination as? LunchDetailViewController,
                 let cell = sender as? RestuarantCollectionViewCell,
                 let indexPath = collectionView.indexPath(for: cell)  else { return }
            
            let restaurant = restaurants[indexPath.row]
            
            destination.restaurant = restaurant 
        } else if segue.identifier == "toMapView" {
            guard let destination = segue.destination as? MapViewController else { return }
                    
            let restaurants = restaurants
            destination.restaurants = restaurants
            print("segue", restaurants.count)
        }
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return restaurants.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RestuarantCollectionViewCell else { return UICollectionViewCell() }
    
        let restaurant = restaurants[indexPath.row]
        
        cell.restaurant = restaurant
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        
        if width > 428 {
            return CGSize(width: width / 2, height: 240)
        } else {
            return CGSize(width: width, height: 240)
        }
    }
}

extension LunchCollectionViewController: UICollectionViewDelegateFlowLayout { }
extension LunchCollectionViewController: UINavigationBarDelegate { }
