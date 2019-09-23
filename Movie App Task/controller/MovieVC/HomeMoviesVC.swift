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
    var moviesRatedArray = [Result]()
    var dummyTitleHeader = ["Now Playing","UpComing","Popular","Top Rated","Latest"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dummyTitleHeader.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width - 8, height: 40)
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind:
        String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
            headerId, for: indexPath) as! HeaderCell
        header.movieMainTitleLabel.text = dummyTitleHeader[indexPath.section]
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
       
       
       
        if indexPath.section == 1 {
            identifier = upComing
        } else if indexPath.section == 2 {
            identifier = popular
        }else if indexPath.section == 3 {
            identifier = topRated
        }else if indexPath.section == 4 {
            identifier = latest
        }  else {
             identifier = cellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MovieCell
     
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    
    //MARK:-User methods
    
//    fileprivate  func fetchData()  {
//        
//        Services.services.getTopRatedMovies { [weak self] (rated, err) in
//            if let err = err {
//                print(err.localizedDescription)
//            }
//            guard let rated = rated else {return}
//            self?.moviesRatedArray = rated.results
//            DataCaching.sharedInstance.cached["RatedMovies"] = rated.results // caching data
//            DispatchQueue.main.async {
//                self?.collectionView.reloadData()
//            }
//        }
//    }
//    
    
    
    fileprivate  func setupCollection()  {
        collectionView.backgroundColor = .white
        collectionView.contentInset.top = 8
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UpComingCell.self, forCellWithReuseIdentifier: upComing)
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: topRated)
        collectionView.register(NowPlayingCell.self, forCellWithReuseIdentifier: nowPlaying)
        collectionView.register(PopluarCell.self, forCellWithReuseIdentifier: popular)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: latest)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
}
