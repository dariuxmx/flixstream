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
    fileprivate let itemsPerRow: CGFloat = 2.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 15.0, bottom: 15.0, right: 15.0)
    
    // Cell
    let reuseIdentifier = "movieCell"
    var movies:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "FLIXSTREAM"
        
        //Movie service
        MovieService.dataService.getMovies(from: MovieEndPoint.playing, parameters: nil, successHandler: { (response) in
            let resultMovies = response.results
//            print("Movie --> \(resultMovies)")
    
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
        //cell style
        cell.contentView.layer.cornerRadius = 5.0
        cell.contentView.layer.masksToBounds = true;
        cell.layer.shadowRadius = 5.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        
        let movie = self.movies[indexPath.row]
        let data = NSData(contentsOf: movie.coverURL)
        
        // Enable this line if you want to show the title, don't forget create the IBOutlet in MovieHomeCell file
        // cell.movieName.text = movie.title
        cell.releaseDate.text = "Release Date \n\(movie.releaseDateText)"
        cell.coverMovie.image = UIImage(data: data! as Data)
        cell.rating.text = "\(movie.voteAverage)"
        return cell
        
        
    }
    

}


extension HomeMoviesViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (CGFloat(itemsPerRow) + 1.0)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: 260)
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
