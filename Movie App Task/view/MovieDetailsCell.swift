//
//  TopRatedCell.swift
//  Movie App Task
//
//  Created by hosam on 8/10/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsCell: BaseCell {
    
    var movie:Result! {
        didSet{
            guard let url = URL(string: "http://image.tmdb.org/t/p/original/\(movie.posterPath)") else { return }
            movieImageView.sd_setImage(with: url)
            movieTitleLabel.text = movie.title
            movieTitleLabel.text =  movie.title
            movieOverviewLabel.text = movie.overview
        }
    }
    
     let movieImageView:UIImageView = {
       let im = UIImageView()
        im.backgroundColor = .gray
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        im.layer.cornerRadius = 8
        im.constrainHeight(constant: 150)
        return im
    }()
    let movieTitleLabel = UILabel(text: "ovie title", font: .systemFont(ofSize: 16), textColor: .black  )
    let movieOverviewLabel = UILabel(text: "overview\n fbf", font: .systemFont(ofSize: 16), textColor: .black, numberOfLines: 2)
    
    
    let seperatoView:UIView = {
       let vi = UIView(backgroundColor: .gray)
        vi.constrainHeight(constant: 3)
        return vi
    }()
    
   
    override func setupViews()  {
        backgroundColor = .white
       stack(movieImageView,movieTitleLabel,movieOverviewLabel,seperatoView, spacing: 4).withMargins(.init(top: 4, left: 8, bottom: 4, right: 0))
        
        
    }
    
    
}
