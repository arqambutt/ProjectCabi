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

        
        if let Cs = object["driverid"]  {
          
        self.driverid = Cs as! String
        }
     
        
        if let Css = object["username"] {
            
             self.userName = Css as! String
            
        }
       
        
        
        if let Csa = object["lat"] {
            
             self.lat = String(describing: Csa)
        }
       
        
        if let Csr = object["lng"] {
            
            self.lon = String(describing: Csr)
        }
   
        
     
        
    }
    
  
 
    
    
}
