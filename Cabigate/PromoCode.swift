//
//  PromoCode.swift
//  Cabigate
//
//  Created by abdur rehman on 7/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation



class promo {
    
    
    
    var  ID = ""
    var  code = ""
    var  description = ""
    var  expiry = ""
    
    
    
    init(data:NSDictionary) {
        
        ID = String(describing: data["ID"] as! NSObject)
        code = String(describing: data["code"] as! NSObject)
        description = String(describing: data["description"] as! NSObject)
        expiry = String(describing: data["expiry"] as! NSObject)
    
    }
}
