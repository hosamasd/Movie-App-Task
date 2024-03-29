//
//  MainTabBarVC.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        setupViewControllers()
        
        
    }
    
    //MARK:-User methods
    
    fileprivate func setupViewControllers() {
        
        let layout = UICollectionViewFlowLayout()
        
        let categories = templateNavControllerVC(title: "Categories ", selectedImage: #imageLiteral(resourceName: "top-rated"), rootViewController: HomeMoviesVC(collectionViewLayout: layout))
//        let account = templateNavControllerVC(title: "Account", selectedImage: #imageLiteral(resourceName: "account"), rootViewController: AccountVC() )
         let search = templateNavControllerVC(title: "Search", selectedImage: #imageLiteral(resourceName: "account"), rootViewController: SearchMoviesVC(collectionViewLayout: layout) )
        
        tabBar.tintColor = .black
        
        viewControllers = [
           search ,
           categories
        ]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavControllerVC(title: String,selectedImage:UIImage, rootViewController: UIViewController ) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        rootViewController.navigationController?.navigationBar.prefersLargeTitles = false
        navController.tabBarItem.title = title
        
        navController.tabBarItem.image = selectedImage
        return navController
    }
}
