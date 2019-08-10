//
//  Services.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import Alamofire

class Services {
    static let services = Services()
    
    fileprivate let apiKey = "9e4052475425b472866635831745fe22"
    
    
    func getAccessToken(username:String,password:String,completion: @escaping (String?, Error?)->())  {
        
        let string =  "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)"
        guard let url = URL(string: string) else { return  }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            
            do {
                let user = try JSONDecoder().decode(UserModel.self, from: data)
                // success
                let token = user.requestToken
                
                self.validateLogin(request_Token: token, username: username, password: password, completion: completion)
                
            } catch  {
                
                self.validateLogin( username: username, password: password, completion: completion)
            }
            }.resume()
        
    }
    
    func makeGenericPost(value: String,parameters: [String:Any],url:URL,completion: @escaping (String?, Error?)->())  {
        let headers = ["content-type": "application/json"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(completionHandler: { (res) in
                
                
                switch res.result {
                case .success:
                    let datas = res.result.value as? [String:Any]
                    guard let values = datas?["\(value)"] as? String else {return}
                    print("my token is ",values)
                    completion(values,nil)
                    
                case .failure(let err):
                    print(err)
                    completion(nil,err)
                }
            })
    }
    
    func validateLogin(request_Token:String? = "",username:String,password:String,completion: @escaping (String?, Error?)->())  {
        guard let urls = URL( string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=9e4052475425b472866635831745fe22") else { return  }
        
        
        let parameters = [
            "username": username,
            "password": password,
            "request_token": request_Token
        ]
        
        makeGenericPost(value: "request_token", parameters: parameters, url: urls, completion: completion)
        
        
    }
    
    
    func getSessionID (completion: @escaping (String?, Error?)->())  {
        let apiKeys = "9e4052475425b472866635831745fe22"
        getAccessToken(username: "hosam_dsa", password: "dsaasd321") { [weak self] (token, err) in
            
            guard let urls = URL( string: "https://api.themoviedb.org/3/authentication/session/new?api_key=\(apiKeys)"),
                let tokens = token else { return  }
            
            let parameters = [
                "request_token": tokens
            ]
            
            
            self?.makeGenericPost(value: "session_id", parameters: parameters, url: urls, completion: completion)
            
        }
        
    }
    
    func makeGenericGet<T:Codable>(url:URL,completion: @escaping (T?, Error?)->())  {
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            
            do {
                let user = try JSONDecoder().decode(T.self, from: data)
                // success
                completion(user,nil)
                
                
                
            } catch let err {
                completion(nil,err)
                
            }
            }.resume()
    }
    
    
    func getUserInfo(completion: @escaping (UserDetailsModel?, Error?)->())  {
        let apiKeys = "9e4052475425b472866635831745fe22"
        getSessionID { [weak self] (session, err) in
            
            guard let sessions = session else {return}
            let urlString = "https://api.themoviedb.org/3/account?session_id=\(sessions)&api_key=\(apiKeys)"
            guard let url = URL(string: urlString) else {return}
            
            self?.makeGenericGet(url: url, completion: completion)
        }
    }
    
    
    
    func getTopRatedMovies(completion: @escaping ( TopRatedModel?,Error?)->())  {
        let topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1"
        guard let url = URL(string: topRated) else { return  }
        makeGenericGet(url: url, completion: completion)
        
    }
}
