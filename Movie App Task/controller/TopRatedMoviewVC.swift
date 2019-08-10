//
//  TopRatedMoviewVC.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class TopRatedMoviewVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    var moviesRatedArray = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        fetchData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesRatedArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TopRatedCell
        let moview = moviesRatedArray[indexPath.item]
        
        cell.movie = moview
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 220)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = moviesRatedArray[indexPath.item]
        
        let movieInfo = MovieInformationVC()
        movieInfo.movieDetails = movie
        navigationController?.pushViewController(movieInfo, animated: true)
    }
    
    func fetchData()  {
        Services.services.getTopRatedMovies { [weak self] (rated, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            guard let rated = rated else {return}
            self?.moviesRatedArray = rated.results
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func setupCollection()  {
        collectionView.backgroundColor = .white
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.contentInset.top = 8
    }
}
