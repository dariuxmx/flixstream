//
//  MovieDetailsViewController.swift
//  FlixStream
//
//  Created by Edwin Dario Gutierrez Pech on 7/27/20.
//  Copyright © 2020 Habanero Studio. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    //MARK: Vars
    var movie: Movie!
    var movieId: Int!
    var updateMovieClosure: ((_ success: Bool) -> Bool)?
    lazy var leftBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(named:"Back Button Icon"), style: .plain, target: self, action: #selector(self.popAction))
        barButtonItem.tintColor = UIColor.white
        return barButtonItem
    }()
    
    //MARK: IBOutlets
    @IBOutlet weak var coverMovieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genresReleaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMoviByIdService()
        self.navigationItem.leftBarButtonItem = leftBarButton
//        onLoadClosure()
    }
    
    func getMoviByIdService (){
        //Movie service
        MovieService.dataService.getMovieById(id: movieId, successHandler: { (response) in
            self.movie = response
            self.setupUI(movieObject: self.movie)
            
        
        }) { (error) in
            print("Api loading error")
        }
    }

    func setupUI(movieObject: Movie) {
        DispatchQueue.main.async {
            let data = NSData(contentsOf: movieObject.coverURL)
           
                self.coverMovieImageView.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.coverMovieImageView.alpha = 1.0
                    self.coverMovieImageView.image = UIImage(data: data! as Data)
                }) { (finished) in
                   print("finished")
                }
            
            
            if let url = NSURL(string: "\(String(describing: movieObject.coverURL))"), let data = NSData(contentsOf: url as URL){
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        self.coverMovieImageView.alpha = 1.0
                        self.coverMovieImageView.image = UIImage.init(data: data as Data)
                    }) { (finished) in
                        print("finished")
                    }
                
            }
            
            self.movieNameLabel.text = movieObject.title
            self.overviewLabel.text = movieObject.overview
            self.genresReleaseDateLabel.text = String("Release Date \n\(movieObject.releaseDateText) | Rate: \(movieObject.voteAverage)")
            }
        }
}


extension MovieDetailsViewController {
    
    @objc func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
