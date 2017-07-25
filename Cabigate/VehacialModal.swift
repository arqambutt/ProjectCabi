//
//  VehacialModal.swift
//  Cabigate
//
//  Created by abdur rehman on 7/22/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


class  VehacialListModal{
    
    


var typeid = ""
var name = ""
var icon = ""

    
    
    
    init(data:NSDictionary) {
        
        typeid = String(describing: data["typeid"] as! NSObject)
        name = String(describing: data["name"] as! NSObject)
        icon = String(describing: data["icon"] as! NSObject)
    
    }
    
}
