//
//  DataCaching.swift
//  Movie App Task
//
//  Created by hosam on 8/12/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import Foundation

class DataCaching: NSObject {
    static let sharedInstance = DataCaching()
    var cached:[String:Any] = [:]
    
  
}
