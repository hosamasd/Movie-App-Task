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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserDetails()
    }
    
    func setupViews()  {
         view.backgroundColor = .lightGray
        let mainLabels = [userIDLabel,userISOLabel,userISO2Label,userNameLabel,userAdultLabel,userNameInfoLabel]
        mainLabels.forEach({$0.constrainHeight(constant: 40)})
        
        let mainStack = getStack(views: avatarUserImageView,userIDLabel,userISOLabel,userISO2Label,userNameLabel,userAdultLabel,userNameInfoLabel, spacing: 8, axis: .vertical)
        mainStack.alignment = .center
        
        view.addSubview(mainStack)
        
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 8, left: 8, bottom: 0, right: 8))
    }
    
    func getUserDetails()  {

        Services.services.getUserInfo { [weak self] (user, err) in
            guard let user = user else {return}
            self?.user = user
            DispatchQueue.main.async {
                self?.addText(user)
            }
            
        }
    }
    
    func addText(_ user: UserDetailsModel)  {
        guard let url = URL(string: baseGravtarlink + user.avatar.gravatar.hash) else { return  }
        avatarUserImageView.sd_setImage(with: url)
        userIDLabel.text = "ID: \(user.id)"
        userISOLabel.text = "iso_639_1: \(user.iso3166_1)"
        userISO2Label.text = "iso_3166_1: \(user.iso639_1)"
        userNameLabel.text = "name: \(user.name )"
        userNameInfoLabel.text = "username: \(user.username)"
        userAdultLabel.text = "include_adult: \(user.includeAdult == true ? "Yes" : "No")"
    }
}
