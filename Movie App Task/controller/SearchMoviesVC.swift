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
    
    let mainLabel = UILabel(text: "please enter your movie name for searching...", font: .systemFont(ofSize: 24), textColor: .black, textAlignment: .center, numberOfLines: 2)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollections()
        setupNavigations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = moviesArray[indexPath.item]
        let newVC = MovieInformationVC(movieRes: result)
        newVC.navigationItem.title = result.title
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func setupCollections()  {
        collectionView.backgroundColor = .white
        collectionView.addSubview(mainLabel)
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellID)
        mainLabel.anchor(top: collectionView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 60, left: 16, bottom: 0, right: 16),size: .init(width: 0, height: 120))
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
            self.reloadContents()
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
                    
                    self.reloadContents()
                }
            })
            
        }
    }
    
    func reloadContents()  {
        DispatchQueue.main.async {
            self.mainLabel.isHidden = self.moviesArray.count == 0 ? false : true
            self.collectionView.reloadData()
        }
    }
    
}

extension String {
    func convertSpacingToValid() -> String {
        return self.contains(" ") ? self : self.replacingOccurrences(of: " ", with: "%20")
        
    }
}
