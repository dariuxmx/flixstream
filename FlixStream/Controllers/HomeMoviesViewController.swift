//
//  HomeMoviesViewController.swift
//  FlixStream
//
//  Created by Edwin Dario Gutierrez Pech on 7/27/20.
//  Copyright © 2020 Habanero Studio. All rights reserved.
//

import UIKit

class HomeMoviesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Movie service
        MovieService.dataService.getMovies(from: MovieEndPoint.playing, parameters: nil, successHandler: { (response) in
            let resultMovies = response.results
            print("Movie --> \(resultMovies)")
        }) { (error) in
            print("Api Error")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
