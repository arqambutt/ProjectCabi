//
//  historyclass.swift
//  Cabigate
//
//  Created by abdur rehman on 6/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


class historyclass{
    
    
    
    var pickup_lat:String?
    var pickup_lng:String?
    
    var drop_lat:String?
    var drop_lng:String?
    
    var pickup_datetime:String?
    
    var total_fare:String?
    
    
    
    var pickup_location:String?
    var drop_location:String?
    
    
    init(data:NSDictionary) {
       
         let Cs = data["pickup_lat"] as! NSObject
        pickup_lat = String(describing: Cs)
        
        let Css = data["pickup_lng"] as! NSObject
        pickup_lng = String(describing: Css)
        
        
        let Csa = data["drop_lat"] as! NSObject
        drop_lat = String(describing: Csa)
        
        let Csr = data["drop_lng"] as! NSObject
        drop_lng = String(describing: Csr)
        
        let Csrf = data["total_fare"] as! NSObject
        total_fare = String(describing: Csrf)
        
        let da = data["drop_location"] as! NSObject
        drop_location = String(describing: da)
        
        let sda = data["pickup_location"] as! NSObject
        pickup_location = String(describing: sda)
        
        
        let kkkk = data["pickup_datetime"] as! NSObject
        pickup_datetime = String(describing: kkkk)
        
        
    }
    
    
    
    
}
