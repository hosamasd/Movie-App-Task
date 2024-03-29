//
//  ViewController.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import ProgressHUD

class LoginVC: UIViewController {
    
    
    
    fileprivate let apiKey = "9e4052475425b472866635831745fe22"
    let gradiantLayer = CAGradientLayer()
    lazy var usernameTextField:CustomTextField = {
        let tf = CustomTextField(padding: 16, height: 50)
        //        tf.keyboardType = .emailAddress
        tf.placeholder = "enter your username"
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        return tf
    }()
    lazy var passwordTextField:CustomTextField = {
        let tf = CustomTextField(padding: 16, height: 50)
        tf.isSecureTextEntry = true
        tf.placeholder = "enter your password"
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    lazy var loginButton:UIButton = {
        let bt = UIButton(title: "Login", titleColor: .white, font: .systemFont(ofSize: 20, weight: .heavy), backgroundColor: .lightGray, target: self, action: #selector(handleLogin))
        bt.backgroundColor = #colorLiteral(red: 0.8273344636, green: 0.09256268293, blue: 0.324395299, alpha: 1)
        bt.setTitleColor(.white, for: .normal)
        bt.layer.cornerRadius = 22
        bt.constrainHeight(constant: 44)
        return bt
    }()
    lazy var verticalStackView:UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            usernameTextField,
            passwordTextField,
            loginButton
            ])
        sv.axis = .vertical
        sv.spacing = 8
        sv.distribution = .fillEqually
        return sv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        checkLoginState()
        setupGradiantLayer()
        setupViews()
       
        setupGestures()
    }
    
    //MARK:-User methods
    
    
    fileprivate  func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(verticalStackView)
        
        
        verticalStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        verticalStackView.centerYInSuperview()
    }
    
    fileprivate  func setupGradiantLayer()  {
        
        let topColor = #colorLiteral(red: 0.989370048, green: 0.3686362505, blue: 0.3827736974, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8902122974, green: 0.1073872522, blue: 0.4597495198, alpha: 1)
        
        gradiantLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradiantLayer.locations = [0,1]
        view.layer.addSublayer(gradiantLayer)
        gradiantLayer.frame = view.bounds
    }
    
    fileprivate func animateView(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.view.transform = .identity
        })
    }
    
    fileprivate func setupGestures()  {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
    }
    
    func invalidInformation(message:String)  {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
       
    }
    
    func errorInfo(err: Error)  {
       ProgressHUD.show(err.localizedDescription)
    
    }
    //TODO:Handle methods
    
  
    
    @objc  func handleLogin()  {
        
//        progressHUDs.textLabel.text = "Please Wait....."
//        progressHUDs.show(in: self.view)
        
        self.handleDismissKeyboard()
        
        guard let username = usernameTextField.text , !username.isEmpty,
            let passowrd = passwordTextField.text, !passowrd.isEmpty else {invalidInformation(message: "Empty fields Not Allowed!"); return  }
        
        
////        Services.services.getAccessToken(username: username, password: passowrd) { [weak self] (token,err) in
////            if let err = err {
////                self?.errorInfo(err: err)
////            }
//        
//            guard token != nil else {self?.invalidInformation(message: "username or password is invalid!");self?.progressHUDs.dismiss();return}
//           self?.progressHUDs.dismiss()
//            
//            Defaults[.username] = username
//            Defaults[.password] = passowrd
//            Defaults[.islogin] = true
//            
//            let mainBar = MainTabBarVC()
//            
//            self?.present(mainBar, animated: true, completion: nil)
//        }
        
    }
    
    @objc func handleTextChange(text: UITextField) ->Bool {
        guard let text = text.text, !text.isEmpty else { return false }
        return true
    }
    
    @objc func handleDismissKeyboard()  {
        view.endEditing(true)
        
        animateView()
    }
    
   
    
}

//
//extension DefaultsKeys{
//
//    static let username = DefaultsKey<String?>("username")
//    static let password = DefaultsKey<String?>("password")
//    static let islogin = DefaultsKey<Bool?>("islogin")
//}
