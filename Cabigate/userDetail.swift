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
    var lName = ""
    var phone = ""
    var userid = ""
    var profilePicUrl = ""
    var picLocationName = ""
    var orignalImg = UIImage()
    var cheak:Bool = false
    var home_address = ""
    var home_lat = ""
    var home_lng = ""
    var work_address = ""
    var work_lat = ""
    var work_lng = ""
        
    
 
    
}


