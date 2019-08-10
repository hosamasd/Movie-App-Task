//
//  MovieInformationVC.swift
//  Movie App Task
//
//  Created by hosam on 8/10/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MovieInformationVC: UIViewController {
    
    var movieDetails:Result! {
        didSet{
            print(movieDetails.overview)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews()  {
        view.backgroundColor = .red
    }
}
