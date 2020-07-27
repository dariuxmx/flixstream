//
//  HomeMoviesViewController.swift
//  FlixStream
//
//  Created by Edwin Dario Gutierrez Pech on 7/27/20.
//  Copyright © 2020 Habanero Studio. All rights reserved.
//

import UIKit

class HomeMoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    //Collection view layout
    fileprivate let itemsPerRow = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    // Cell
    let reuseIdentifier = "movieCell"
    var movies:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Movie service
        MovieService.dataService.getMovies(from: MovieEndPoint.playing, parameters: nil, successHandler: { (response) in
            let resultMovies = response.results
            print("Movie --> \(resultMovies)")
    
            self.movies.append(contentsOf: resultMovies)
            OperationQueue.main.addOperation {
                self.collectionViewMovies.reloadData()
            }
            
        }) { (error) in
            print("Api loading error")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieHomeCell
        let movie = self.movies[indexPath.row]
        
        cell.movieName.text = movie.title
        
        return cell
        
        
    }
    

}
