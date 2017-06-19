//
//  userData.swift
//  Cabigate
//
//  Created by abdur rehman on 6/4/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


class userData {
    
    static var instance = userData()
    static var object:userData {
        
        return instance
    }
    
    var uId:String = ""
    var fName:String = ""
    var email:String = ""
    var keymatch :String = ""
    var OPT:String = ""
    var token:String = ""
    
    
    

    
}
