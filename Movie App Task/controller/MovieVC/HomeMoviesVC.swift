//
//  TopRatedMoviewVC.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import JGProgressHUD


class HomeMoviesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let headerId = "headerId"
    let nowPlaying = "nowPlaying"
    let upComing = "upComing"
    let popular = "popular"
     let topRated = "topRated"
    let latest = "latest"
    var moviesRatedArray = [Results]()
    var dummyTitleHeader = ["Now Playing","UpComing","Popular","Top Rated","Latest"]
    
    var moviesArrayResults = [MovieModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        fetchData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArrayResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width - 8, height: 40)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCell
        let movie = moviesArrayResults[indexPath.item]
        
        cell.titleLabel.text = dummyTitleHeader[indexPath.item]
        cell.horizentalCollectionView.movieArray = movie
        cell.horizentalCollectionView.collectionView.reloadData()
        return cell
    }
    
    func fetchData()  {
       
        
        var group1:MovieModel?
        var group2:MovieModel?
        var group3:MovieModel?
//        var group4:MovieModel?

        let disptachGroup = DispatchGroup()

        disptachGroup.enter()
        Services.services.fetchNowPlaying { (movie, err) in
            disptachGroup.leave()

            group1 = movie
        }


        disptachGroup.enter()
        Services.services.fetchUpComing { (movie, err) in
            disptachGroup.leave()

            group2 = movie
        }
        disptachGroup.enter()
        Services.services.fetchPopular { (movie, err) in
            disptachGroup.leave()

            group3 = movie
        }


//        disptachGroup.enter()
//        print(32432)
//        Services.services.fetchLatest { (movie, err) in
//            disptachGroup.leave()
//
//            group4 = movie
//        }


        // when finish
        disptachGroup.notify(queue: .main) {

//            self.activityIndicator.stopAnimating()

            if let group = group1 {
                self.moviesArrayResults.append(group)
            }
            if let group = group2 {
                self.moviesArrayResults.append(group)
            }
            if let group = group3 {
                self.moviesArrayResults.append(group)
            }
//            if let group = group4 {
//                self.moviesArrayResults.append(group)
//            }

            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    
    //MARK:-User methods
    
    
    fileprivate  func setupCollection()  {
        collectionView.backgroundColor = .white
        collectionView.contentInset.top = 8
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
}
