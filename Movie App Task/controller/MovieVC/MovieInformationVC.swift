//
//  MovieInformationVC.swift
//  Movie App Task
//
//  Created by hosam on 8/10/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import SDWebImage

class MovieInformationVC: UIViewController {
    
    fileprivate let movieDetails:Results
    
    init(movieRes:Results) {
        self.movieDetails = movieRes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let movieImageView:UIImageView = {
        let im = UIImageView()
        im.backgroundColor = .red
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        im.layer.cornerRadius = 8
        im.constrainHeight(constant: 250)
        return im
    }()
    let movieTitleLabel = UILabel(text: " ", font: .systemFont(ofSize: 20), textColor: .black, textAlignment: .center)
    let voteAverageLabel = UILabel(text: " ", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    let releaseDateLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    
    let popularityLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    let adultInfoLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    let overviewLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black, numberOfLines: 0)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
        
    }
    
    //MARK:-User methods
    
    fileprivate func setupViews()  {
        let mainLabels = [movieTitleLabel,voteAverageLabel,releaseDateLabel,popularityLabel,adultInfoLabel]
        mainLabels.forEach({$0.constrainHeight(constant: 30)})
        
        overviewLabel.sizeToFit()
        view.backgroundColor = .lightGray
        
        let mainStack = getStack(views: movieImageView,movieTitleLabel,voteAverageLabel,releaseDateLabel,popularityLabel,adultInfoLabel,overviewLabel, spacing: 4 ,distribution: .fill, axis: .vertical)
        view.addSubview(mainStack)
        
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 16, left: 8, bottom: 0, right: 8))
        
    }
    
    
    func loadData()  {
        guard let url = URL(string: "http://image.tmdb.org/t/p/original/\(movieDetails.posterPath)") else { return }
        movieImageView.sd_setImage(with: url)
        movieTitleLabel.text = movieDetails.title
        voteAverageLabel.text = "Vote average: \(movieDetails.voteAverage)"
        releaseDateLabel.text = "Release date: \(movieDetails.releaseDate)"
        popularityLabel.text = "Popularity: \(movieDetails.popularity)"
        adultInfoLabel.text = "Adult Info: \(movieDetails.adult == true ? "Yes" : "No" )"
        overviewLabel.text = "Overview : \(movieDetails.overview)"
    }
    
    
}
