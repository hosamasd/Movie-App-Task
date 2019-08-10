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
    
    //    let posterPath = "/9O7gLzmreU0nGkIB6K3BsJbzvNv.jpg"
    //
    //    fileprivate let  imageposter = "http://image.tmdb.org/t/p/original\(posterPath)"
    
    
    //    func getAccessToken(completion: @escaping (UserModel?, Error?)->())  {
    //        var token:String
    //
    //        let string =  "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)"
    //        guard let url = URL(string: string) else { return  }
    //
    //        URLSession.shared.dataTask(with: url) { (data, res, err) in
    //            guard let data = data else {return}
    //
    //            do {
    //                let user = try JSONDecoder().decode(UserModel.self, from: data)
    //                // success
    //                completion(user,nil)
    //
    //            } catch let err {
    //             completion(nil,err)
    //            }
    //            }.resume()
    //
    //    }
    
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
                
            } catch let err {
                
                self.validateLogin( username: username, password: password, completion: completion)
            }
            }.resume()
        
    }
    
    
    func validateLogin(request_Token:String? = "",username:String,password:String,completion: @escaping (String?, Error?)->())  {
        
        
        let headers = ["content-type": "application/json"]
        let parameters = [
            "username": username,
            "password": password,
            "request_token": request_Token
        ]
        
        
        guard let urls = URL( string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=9e4052475425b472866635831745fe22") else { return  }
        Alamofire.request(urls, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(completionHandler: { (res) in
                
                
                switch res.result {
                case .success:
                    print(res)
                    completion(request_Token,nil)
                case .failure(let err):
                    print(err)
                    completion(request_Token,err)
                }
            })
        print(request_Token)
    }
    
//    func getUserAccountToken(completion: @escaping (String?, Error?)->())  {
//        
//        let string =  "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)"
//        guard let url = URL(string: string) else { return  }
//        
//        URLSession.shared.dataTask(with: url) { (data, res, err) in
//            guard let data = data else {return}
//            
//            do {
//                let user = try JSONDecoder().decode(UserModel.self, from: data)
//                // success
//                let token = user.requestToken
//                
//                self.getSessionID(token: token, completion: completion)
//                
//            } catch let err {
//                
//                self.getSessionID(, completion: completion)
//            }
//            }.resume()
//    }
    
    func getSessionID (completion: @escaping (String?, Error?)->())  {
        
        getAccessToken(username: "hosam_dsa", password: "dsaasd321") { (token, err) in
            print(token)
        
           
        
        let headers = ["content-type": "application/json"]
        let parameters = [
            "request_token": token
         ]

        guard let token = token else { return  }

            guard let urls = URL( string: "https://api.themoviedb.org/3/authentication/session/new?api_key=\(self.apiKey)") else { return  }
        Alamofire.request(urls, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(completionHandler: { (res) in


                switch res.result {
                case .success (let data):
                    if  let datas = res.result.value as? [String:Any] {
                        guard let session = datas["session_id"] as? String else {return}
                         completion(session,nil)
                    }

                case .failure(let err):

                    completion(nil,nil)
                }
            })
        }
       
    }
    
    func getUserInfo(completion: @escaping (UserDetailsModel?, Error?)->())  {
         let apiKeys = "9e4052475425b472866635831745fe22"
        getSessionID { [weak self] (session, err) in
           
            guard let sessions = session else {return}
             print("session is ",sessions)
//            let urlString = "https://api.themoviedb.org/3/account?session_id=f1d3d673d0869a249b0718ff895c035f115c6654&api_key=9e4052475425b472866635831745fe22"
            
            let urlString = "https://api.themoviedb.org/3/account?session_id=\(sessions)&api_key=\(apiKeys)"
            guard let url = URL(string: urlString) else {return}
            
            URLSession.shared.dataTask(with: url) { (data, res, err) in
                guard let data = data else {return}
                
                do {
                    let user = try JSONDecoder().decode(UserDetailsModel.self, from: data)
                    // success
                completion(user,nil)
                    
                  
                    
                } catch let err {
                    completion(nil,err)
                   
                }
                }.resume()
            
        }
    }
//    func getUpComingMovies(completion: @escaping ( TopRatedModel?,Error?)->())  {
//        let upComingMoviesUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1"
//
//        guard let url = URL(string: upComingMoviesUrl) else { return  }
//       URLSession.shared.dataTask(with: url) { (data, res, err) in
//            guard let data = data else {return}
//
//            do {
//                let comingMovie = try JSONDecoder().decode(TopRatedModel.self, from: data)
//                // success
//                completion(comingMovie,nil)
//
//            } catch let err {
//                completion(nil,err)
//
//            }
//            }.resume()
//
//    }
    
    func getTopRatedMovies(completion: @escaping ( TopRatedModel?,Error?)->())  {
        let topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1"
        
       
        guard let url = URL(string: topRated) else { return  }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            
            do {
                let ratedMovie = try JSONDecoder().decode(TopRatedModel.self, from: data)
                // success
                completion(ratedMovie,nil)
                
            } catch let err {
                completion(nil,err)
                
            }
            }.resume()
        
    }
}
