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
    
    var movie:Results! {
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
    let movieTitleLabel = UILabel(text: "", font: .systemFont(ofSize: 24), textColor: .black  )
    let movieOverviewLabel = UILabel(text: "", font: .systemFont(ofSize: 20), textColor: .lightGray, numberOfLines: 3)
    
    
    let seperatoView:UIView = {
       let vi = UIView(backgroundColor: .gray)
        vi.constrainHeight(constant: 1)
        return vi
    }()
    
   
    override func setupViews()  {
        backgroundColor = .white
       stack(movieImageView,movieTitleLabel,movieOverviewLabel,seperatoView, spacing: 4).withMargins(.init(top: 4, left: 8, bottom: 0, right: 0))
        
        
    }
    
    
}
