//
//  Services.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration

class Services {
    static let services = Services()
    
    fileprivate let apiKey = "9e4052475425b472866635831745fe22"
    
    func getInfoMovie(url: String,completion: @escaping ( MovieModel?,Error?)->())  {
        
        guard let urls = URL(string: url) else{return}
        
        URLSession.shared.dataTask(with: urls) { (data, res, err) in
            guard let data = data else {return}
            
            do {
                let user = try JSONDecoder().decode(MovieModel.self, from: data)
                // success
                completion(user,nil)
                
                
                
            } catch let err {
                completion(nil,err)
                
            }
            }.resume()
    
    }
    
    func fetchNowPlaying(completion: @escaping ( MovieModel?,Error?)->())  {
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1"
       
        guard let urls = URL(string: urlString) else{return}
         makeGenericGet(url: urls, completion: completion)
//        getInfoMovie(url: urlString, completion: completion)
       
    }
    
    func fetchUpComing(completion: @escaping ( MovieModel?,Error?)->())  {
        let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1"
        getInfoMovie(url: urlString, completion: completion)
    }
    
    func fetchPopular(completion: @escaping ( MovieModel?,Error?)->())  {
         let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        guard let urls = URL(string: urlString) else{return}
        makeGenericGet(url: urls, completion: completion)
//        getInfoMovie(url: urlString, completion: completion)
    }
    
    func fetchLatest(completion: @escaping ( MovieModel?,Error?)->())  {
        let urlString = "https://api.themoviedb.org/3/movie/latest?api_key=\(apiKey)&language=en-US"
        guard let urls = URL(string: urlString) else{return}
        makeGenericGet(url: urls, completion: completion)
    }
    
    func getTopRatedMovies(completion: @escaping ( MovieModel?,Error?)->())  {
        let topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1"
         guard let urls = URL(string:   topRated) else{return}
         makeGenericGet(url: urls, completion: completion)
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
//
    
    
    
    
   
    
    func getSearchedMovie(text: String,completion: @escaping ( MovieModel?,Error?)->())  {
        
        let url =  "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(text)&page=1&include_adult=false"
      guard  let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  } //replace " " with "%20" in url
        guard let urls = URL(string: urlString) else { return  }
        
     makeGenericGet(url: urls, completion: completion)

        
    }
    
    
    
//    // check internet avaiable or not
//    func isInternetAvailable() -> Bool
//    {
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
//                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
//            }
//        }
//
//        var flags = SCNetworkReachabilityFlags()
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
//            return false
//        }
//        let isReachable = flags.contains(.reachable)
//        let needsConnection = flags.contains(.connectionRequired)
//        return (isReachable && !needsConnection)
//    }
    
    
    //    func getAccessToken(username:String,password:String,completion: @escaping (String?, Error?)->())  {
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
    //                self.validateLogin(request_Token: token, username: username, password: password, completion: completion)
    //
    //            } catch let err {
    //                print(err.localizedDescription)
    ////                self.validateLogin( username: username, password: password, completion: completion)
    //            }
    //            }.resume()
    //
    //    }
    //
    //    func makeGenericPost(value: String,parameters: [String:Any],url:URL,completion: @escaping (String?, Error?)->())  {
    //        let headers = ["content-type": "application/json"]
//            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//                .responseJSON(completionHandler: { (res) in
//
//
//                    switch res.result {
//                    case .success:
//                        let datas = res.result.value as? [String:Any]
//                        if datas?["success"] as? Bool ==  true{
//                        guard let values = datas?["\(value)"] as? String else {return}
//                        print("my token is ",values)
//                        completion(values,nil)
//                        }else  {
//                            completion(nil, nil)
//                        }
//                    case .failure(let err):
//                        print(err)
//                        completion(nil,err)
//                    }
//                })
    //    }
    //
    //    func validateLogin(request_Token:String? = "",username:String,password:String,completion: @escaping (String?, Error?)->())  {
    //        guard let urls = URL( string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=9e4052475425b472866635831745fe22") else { return  }
    //
    //
//            let parameters:  [String : Any] = [
//                "username": username,
//                "password": password,
//                "request_token": request_Token ?? ""
//            ]
    //
    //        makeGenericPost(value: "request_token", parameters: parameters , url: urls, completion: completion)
    //
    //
    //    }
    //
    //
    //    func getSessionID (completion: @escaping (String?, Error?)->())  {
    //        let apiKeys = "9e4052475425b472866635831745fe22"
    //        getAccessToken(username: "hosam_dsa", password: "dsaasd321") { [weak self] (token, err) in
    //
    //            guard let urls = URL( string: "https://api.themoviedb.org/3/authentication/session/new?api_key=\(apiKeys)"),
    //                let tokens = token else { return  }
    //
    //            let parameters = [
    //                "request_token": tokens
    //            ]
    //
    //
    //            self?.makeGenericPost(value: "session_id", parameters: parameters, url: urls, completion: completion)
    //
    //        }
    //
    //    }
    //
    
    //    func getUserInfo(completion: @escaping (UserDetailsModel?, Error?)->())  {
    //        let apiKeys = "9e4052475425b472866635831745fe22"
    //        getSessionID { [weak self] (session, err) in
    //
    //            guard let sessions = session else {return}
    //            let urlString = "https://api.themoviedb.org/3/account?session_id=\(sessions)&api_key=\(apiKeys)"
    //            guard let url = URL(string: urlString) else {return}
    //
    //            self?.makeGenericGet(url: url, completion: completion)
    //        }
    //    }
}



