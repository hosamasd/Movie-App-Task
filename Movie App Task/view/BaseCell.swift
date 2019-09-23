//
//  BaseCell.swift
//  Movie App Task
//
//  Created by hosam on 8/18/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()  {
        
    }
}
