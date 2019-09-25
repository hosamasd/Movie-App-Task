//
//  FavoriteMoviesVC.swift
//  Movie App Task
//
//  Created by hosam on 9/23/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class SearchMoviesVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let cellID = "cellID"
    
     let searchController = UISearchController(searchResultsController: nil)
    var moviesArray = [Results  ]()
    var timer:Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollections()
        setupNavigations()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchCell
        let result = moviesArray[indexPath.item]
        
        cell.movieResult = result
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 200)
    }
    
    func setupCollections()  {
        collectionView.backgroundColor = .white
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func setupNavigations()  {
        self.definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.placeholder = "Search for Movies"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
  
}

extension SearchMoviesVC: UISearchBarDelegate{
    
    
}

extension SearchMoviesVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty{
            view.endEditing(true)
            moviesArray.removeAll()
             self.collectionView.reloadData()
        }else {
            let text = searchController.searchBar.text!.lowercased()
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (time) in
                Services.services.getSearchedMovie(text: text) { (movi, err) in
                    if let err = err {
                        print(err.localizedDescription);return
                    }
                    guard let movi = movi else{return}
                    self.moviesArray = movi.results
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }
                
                
            
//            filterUsers(text:text)
        })
//        collectionView.reloadData()
           
        
    }
        
        
    }
    
    func filterUsers(text:String)  {
//        userResults = userArray.filter({$0.name.lowercased().range(of: text )  != nil})
    }
    
}
