//
//  freeRideMODAL.swift
//  Cabigate
//
//  Created by abdur rehman on 7/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


class freeRideModal {
    
    
    
       var  currency = ""
       var  expiry = ""
       var  freeridevalue = ""
       var  invitaion_link = ""
       var  invitaion_message = ""
    
    
    init(data:NSDictionary) {
        
        currency = String(describing: data["currency"] as! NSObject)
        expiry = String(describing: data["expiry"] as! NSObject)
        freeridevalue = String(describing: data["freeridevalue"] as! NSObject)
        invitaion_link = String(describing: data["invitaion_link"] as! NSObject)
        invitaion_message = String(describing: data["invitaion_message"] as! NSObject)
    }

    
    deinit {
        print("deinit")
    }
}
