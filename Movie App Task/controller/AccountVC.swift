//
//  AccountVC.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import SDWebImage

class AccountVC: UIViewController {
    
    let baseGravtarlink = "https://www.gravatar.com/avatar/"
    var userInfoDetails: UserDefaults?
    
    var user:UserDetailsModel?
    
    let avatarUserImageView:UIImageView = {
        let im = UIImageView(backgroundColor: .gray)
        im.contentMode = .scaleAspectFit
        im.clipsToBounds = true
        im.layer.cornerRadius = 50
        im.constrainHeight(constant: 100)
        im.constrainWidth(constant: 100)
        return im
    }()
    
    lazy var userIDLabel = UILabel(text: "", font: .systemFont(ofSize: 20), textColor: .black, textAlignment: .center)
    lazy var userISOLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    lazy var userNameLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    
    lazy var userAdultLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    lazy var userNameInfoLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    lazy var userISO2Label = UILabel(text: "" , font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
        checkInternet()
//        addTextUsingCachedDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                getUserDetails()     //for get data using api
        addTextUsingCachedDetails() // get data from cached
    }
    
    //MARK:-User methods
    
    func checkInternet()  {
//        if Services.services.isInternetAvailable() {
//            // internet is find
//            getUserDetails()
//        }else {
//            // no internet
//            addTextUsingCachedDetails()
//        }
    }
    
   fileprivate func setupViews()  {
        view.backgroundColor = .lightGray
        let mainLabels = [userIDLabel,userISOLabel,userISO2Label,userNameLabel,userAdultLabel,userNameInfoLabel]
        mainLabels.forEach({$0.constrainHeight(constant: 40)})
        
        let mainStack = getStack(views: avatarUserImageView,userIDLabel,userISOLabel,userISO2Label,userNameLabel,userAdultLabel,userNameInfoLabel, spacing: 8, axis: .vertical)
        mainStack.alignment = .center
        
        view.addSubview(mainStack)
        
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 8, left: 8, bottom: 0, right: 8))
    }
    
  fileprivate  func getUserDetails()  {
        
//        Services.services.getUserInfo { [weak self] (user, err) in
//            guard let user = user else {return}
//            self?.user = user
//            DispatchQueue.main.async {
//                self?.addText(user)
//            }
//            
//        }
    }
    
  fileprivate  func addText(_ user: UserDetailsModel)  {
        guard let url = URL(string: baseGravtarlink + user.avatar.gravatar.hash) else { return  }
        avatarUserImageView.sd_setImage(with: url)
        userIDLabel.text = "ID: \(user.id)"
        userISOLabel.text = "iso_639_1: \(user.iso3166_1)"
        userISO2Label.text = "iso_3166_1: \(user.iso639_1)"
        userNameLabel.text = "name: \(user.name )"
        userNameInfoLabel.text = "username: \(user.username)"
        userAdultLabel.text = "include_adult: \(user.includeAdult == true ? "Yes" : "No")"
        
        cachedData(user)
    }
    
  fileprivate  func addTextUsingCachedDetails()  {
        
        if let data = UserDefaults.standard.value(forKey: "userInfo") as? [String: Any] {
            let urlString = "\(baseGravtarlink)\(String(describing: user?.avatar.gravatar.hash)))"
////            let urlString = "\(baseGravtarlink)\(String(describing: user?.avatar.gravatar.hash))"
//            avatarUserImageView.loadImageUsingCacheWithUrlString(urlString)
            guard let url = URL(string: urlString) else { return  }
            avatarUserImageView.sd_setImage(with: url)
            
           
            userIDLabel.text = "ID: \(data["id"] as? Int ?? 0)"
            userISOLabel.text = "iso_639_1: \(data["iso639_1"] as? String ?? "")"
            userISO2Label.text = "iso_3166_1: \(data["iso_3166_1"] as? String ?? "")"
            userNameLabel.text = "name: \(data["name"] as? String ?? "" )"
            userNameInfoLabel.text = "username: \(data["username"] as? String ?? "")"
            userAdultLabel.text = "include_adult: \(data["includeAdult"] as? Bool == true ? "Yes" : "No")"
            
        }
    }
    
  fileprivate  func cachedData(_ user: UserDetailsModel)  {
        let datas: [String:Any] = ["id": user.id,
                                   "gravatar": user.avatar.gravatar.hash,
                                   "includeAdult": user.includeAdult,
                                   "iso3166_1": user.iso3166_1,
                                   "iso639_1": user.iso639_1,
                                   "username": user.username,
                                   "name": user.name,
                                   
                                   ]
        let defaults    = UserDefaults.standard
        defaults.set(datas, forKey: "userInfo")
        defaults.synchronize()
        
        
    }
    
}
