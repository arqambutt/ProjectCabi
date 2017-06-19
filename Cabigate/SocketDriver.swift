//
//  SocketDriver.swift
//  Cabigate
//
//  Created by abdur rehman on 6/19/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

class socketDriver {
    

    
    
    var driverid = ""
    var lat = ""
    var lon = ""
    var userName = ""
    
    init(object:NSDictionary) {

        
        let Cs = object["driverid"] as! NSObject
        self.driverid = String(describing: Cs)
        
        let Css = object["username"] as! NSObject
        self.userName = String(describing: Css)
        
        
        let Csa = object["lat"] as! NSObject
        self.lat = String(describing: Csa)
        
        let Csr = object["lng"] as! NSObject
        self.lon = String(describing: Csr)
        
     
        
    }
    
    
}
