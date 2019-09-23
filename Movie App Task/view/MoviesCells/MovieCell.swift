//
//  MovieCell.swift
//  Movie App Task
//
//  Created by hosam on 8/18/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MovieCell: BaseCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let cellID = "cellID"
    
    lazy var  collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(MovieDetailsCell.self, forCellWithReuseIdentifier: cellID)
        
        return cv
    }()
    var movieArray = [Result]()
    
//     let infoLabel = UILabel(text: "please wait until data reterived", font: .systemFont(ofSize: 25), textColor: .black, textAlignment: .left)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MovieDetailsCell
        let movie = movieArray[indexPath.item]
        
        cell.movie = movie
        cell.backgroundColor = .yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width - 128, height: frame.height)
    }
    
    override func setupViews() {
       
        addSubview(collectionView)
        
        collectionView.fillSuperview()
         fetchMovies()
    }
    
    func fetchMovies() {
        Services.services.fetchNowPlaying { [weak self] (movie, err) in
            self?.getMovies(err: err, movie: movie)
//            if let err = err {
//                print(err.localizedDescription)
//                return
//            }
//
//            guard let movies = movie?.results else {return}
//            self?.movieArray = movies
//            DispatchQueue.main.async {
//                self?.collectionView.reloadData()
//            }
            
        }
        
     }
    
    func getMovies(err:Error?,movie:MovieModel?)  {
        if let err = err {
            print(err.localizedDescription)
            return
        }

        guard let movies = movie?.results else {return}
        self.movieArray = movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}
