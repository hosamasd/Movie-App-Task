//
//  MovieCell.swift
//  Movie App Task
//
//  Created by hosam on 8/18/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MovieCell: BaseCell {
    
    let titleLabel:UILabel = {
        let la = UILabel(text: "", font: .systemFont(ofSize: 30), textColor: .black, textAlignment: .left, numberOfLines: 1)
        
        return la
    }()
    let horizentalCollectionView = MovieListHorizentalVC()
    
    override func setupViews() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(horizentalCollectionView.view)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 16, bottom: 0, right: 0))
        
        horizentalCollectionView.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
}
