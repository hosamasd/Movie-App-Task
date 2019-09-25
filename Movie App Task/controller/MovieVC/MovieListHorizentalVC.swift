//
//  MovieListHorizentalVC.swift
//  Movie App Task
//
//  Created by hosam on 9/23/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MovieListHorizentalVC:  SnappingHorizentalVC  {
    
    fileprivate let cellId = "cellId"

    var movieArray:MovieModel?
     var handleIndexSelected:((Results) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieDetailsCell
        let movie = movieArray?.results[indexPath.item]
        
        cell.movie = movie
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = self.movieArray?.results[indexPath.item] {
            handleIndexSelected?(index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 128, height: view.frame.height)
    }
    
    
    func getMovies(err:Error?,movie:MovieModel?)  {
        if let err = err {
            print(err.localizedDescription)
            return
        }
        
        guard let movies = movie?.results else {return}
        //        self.movieArray = movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
}

    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.register(MovieDetailsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}
