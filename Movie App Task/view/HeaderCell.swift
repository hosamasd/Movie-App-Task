//
//  HeaderCell.swift
//  Movie App Task
//
//  Created by hosam on 8/18/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class HeaderCell: BaseCell {
    
    let movieMainTitleLabel = UILabel(text: "main title", font: .systemFont(ofSize: 24), textColor: .black)
    override func setupViews() {
        backgroundColor = .white
        addSubview(movieMainTitleLabel)
        
        movieMainTitleLabel.fillSuperview(padding: .init(top: 0, left: 8, bottom: 0, right: 0))
    }
}
