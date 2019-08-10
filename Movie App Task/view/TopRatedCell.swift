//
//  TopRatedCell.swift
//  Movie App Task
//
//  Created by hosam on 8/10/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class TopRatedCell: UICollectionViewCell {
    
    var movie:Result! {
        didSet{
            movieTitleLabel.text = movie.title
            voteAverageLabel.text = String(movie.voteAverage)
             releaseDateLabel.text = movie.releaseDate
        }
    }
    
    
    let movieImageView:UIImageView = {
       let im = UIImageView()
        im.backgroundColor = .red
        im.contentMode = .scaleAspectFit
        im.clipsToBounds = true
        im.layer.cornerRadius = 8
        im.constrainHeight(constant: 150)
        return im
    }()
    let movieTitleLabel = UILabel(text: "ovie title", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let voteAverageLabel = UILabel(text: "vote average", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let releaseDateLabel = UILabel(text: "release date", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .left, numberOfLines: 0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()  {
        backgroundColor = .white
        stack(movieImageView,movieTitleLabel,voteAverageLabel,releaseDateLabel, spacing: 4, distribution: .fillProportionally).withMargins(.init(top: 4, left: 8, bottom: 4, right: 8))
    }
}
