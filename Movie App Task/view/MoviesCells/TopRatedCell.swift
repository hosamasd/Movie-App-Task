//
//  TopRatedCell.swift
//  Movie App Task
//
//  Created by hosam on 8/18/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class TopRatedCell:MovieCell  {
   
    
        
        override  func fetchMovies() {
            
            
            Services.services.getTopRatedMovies { [weak self] (movie, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                guard let movies = movie?.results else {return}
                self?.movieArray = movies
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            }
            
            
        }
    
}
