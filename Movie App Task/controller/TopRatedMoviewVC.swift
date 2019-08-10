//
//  TopRatedMoviewVC.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import JGProgressHUD

class TopRatedMoviewVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    var moviesRatedArray = [Result]()
     var progressHUDs = JGProgressHUD(style: .dark)
    let infoLabel = UILabel(text: "please wait until data reterived", font: .systemFont(ofSize: 25), textColor: .black, textAlignment: .center)
    
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
    
    //MARK:-User methods
    
  fileprivate  func fetchData()  {
    
    progressHUDs.textLabel.text = "fetching data Wait!"
    progressHUDs.show(in: self.view)
    
        Services.services.getTopRatedMovies { [weak self] (rated, err) in
            if let err = err {
                print(err.localizedDescription)
                self?.progressHUDs.textLabel.text = err.localizedDescription
                self?.progressHUDs.show(in: self!.view)
            }
            self?.hideData()
            guard let rated = rated else {return}
            self?.moviesRatedArray = rated.results
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func hideData()  {
        progressHUDs.dismiss()
        DispatchQueue.main.async {
            self.infoLabel.alpha = 0
        }
        
    }
  fileprivate  func setupCollection()  {
        collectionView.backgroundColor = .white
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.contentInset.top = 8
   
    collectionView.addSubview(infoLabel)
    infoLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 8, left: 8, bottom: 0, right: 8))
   
    
    }
}
