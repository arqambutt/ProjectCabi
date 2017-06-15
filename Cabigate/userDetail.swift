//
//  userDetail.swift
//  Cabigate
//
//  Created by abdur rehman on 6/7/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

// sigleton modal
class userDetail {
    
   static var object = userDetail()
    
    static var instance:userDetail {
        return object
    }
    
    
    var email = ""
    var fname = ""
    var phone = ""
    var userid = ""
    
    
    
    
}


