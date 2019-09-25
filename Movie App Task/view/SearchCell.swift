//
//  SearchCell.swift
//  Movie App Task
//
//  Created by hosam on 9/25/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class SearchCell: BaseCell {
    
    var movieResult:Results! {
        didSet{
            guard let url = URL(string: "http://image.tmdb.org/t/p/original/\(movieResult.posterPath)") else { return }
            movieImageView.sd_setImage(with: url)
            movieNameLabel.text = movieResult.title
            movieAverageLabel.text =  String(describing: movieResult.voteAverage)
            movieOverviewLabel.text = movieResult.overview
        }
    }
    
    
    let movieImageView:UIImageView = {
        let im = UIImageView()
        im.constrainWidth(constant: 80)
        im.constrainHeight(constant: 80)
        im.layer.cornerRadius = 40
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        return im
    }()
    let movieNameLabel = UILabel(text: "user name", font: .boldSystemFont(ofSize: 18), textColor: .black)
    let movieAverageLabel = UILabel(text: "hellld dfgdfgd", font: .systemFont(ofSize: 16), textColor: .lightGray)
    let movieOverviewLabel = UILabel(text: "hellld dfgdfgd \n fdg", font: .systemFont(ofSize: 14), textColor: .lightGray,textAlignment: .left,numberOfLines: 4)
    let seperatorView:UIView = {
        let vi=UIView(backgroundColor: .gray)
        vi.constrainHeight(constant: 1)
        return vi
    }()
    
    override func setupViews() {
        backgroundColor = .white
        addSubview(seperatorView)
        hstack(movieImageView,stack(movieNameLabel,movieAverageLabel,movieOverviewLabel), spacing: 8,alignment:.center).withMargins(.init(top: -32, left: 16, bottom: 0, right: 8))
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 80, bottom: 0, right: 0))
//        stack(hstack( view,stack(userNameLabel,userStatusLabel, spacing: 4),rightImageView, spacing: 8,alignment: .center),seperatorView, spacing: 4).withMargins(.init(top: 8, left: 16, bottom: 0, right: 8))
    }
}
