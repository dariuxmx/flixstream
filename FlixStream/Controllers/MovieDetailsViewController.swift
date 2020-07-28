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
        
        self.navigationItem.leftBarButtonItem = leftBarButton
        onLoadClosure()
    }
    
    func onLoadClosure() {
        guard let result = updateMovieClosure?(true) else { return }
    
        if (result) {
            let data = NSData(contentsOf: movie.coverURL)
            self.coverMovieImageView.alpha = 0.0
            OperationQueue.main.addOperation {
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.coverMovieImageView.alpha = 1.0
                    self.coverMovieImageView.image = UIImage(data: data! as Data)
                }) { (finished) in
                   print("finished")
                }
            }
        }else if let url = NSURL(string: "\(String(describing: movie?.coverURL))"), let data = NSData(contentsOf: url as URL){
            OperationQueue.main.addOperation {
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                    self.coverMovieImageView.alpha = 1.0
                    self.coverMovieImageView.image = UIImage.init(data: data as Data)
                }) { (finished) in
                    print("finished")
                }
            }
        }
        
        movieNameLabel.text = movie?.title
        overviewLabel.text = movie?.overview
        genresReleaseDateLabel.text = String("Release Date \n\(movie.releaseDateText) | Rate: \(movie.voteAverage)")
    }

}


extension MovieDetailsViewController {
    
    @objc func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
