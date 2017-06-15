//
//  NearestDriver.swift
//  Cabigate
//
//  Created by abdur rehman on 6/4/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

class NDCLASS {

    
    var company_serial:String = ""
    var driver_id:String = ""
    var taxi_model:String = ""
    var driver_name:String = ""
    var phone:String = ""
    var Callsign:String = ""
    var taxi_color:String = ""
    var taxi_type:String = ""
    var lat:Double = 0.0
    var lon:Double = 0.0
    var distance:Double = 0.0
    var eta_time:Double = 0
    
    
    init(data:NSDictionary) {
        
        let Cs = data["company_serial"] as! NSObject
        company_serial = String(describing: Cs)
        let Di = data["driver_id"] as! NSObject
        driver_id = String(describing: Di)
        let Tm = data["taxi_model"] as! NSObject
        taxi_model = String(describing: Tm)
        let DN = data["driver_name"] as! NSObject
        driver_name = String(describing: DN)
        let p = data["phone"] as! NSObject
        phone = String(describing: p)
        let CS = data["Callsign"] as! NSObject
        Callsign = String(describing: CS)
        let Tc = data["taxi_color"] as! NSObject
        taxi_color = String(describing: Tc)
        let TT = data["taxi_type"] as! NSObject
        taxi_type = String(describing: TT)
        let l = data["lat"] as! NSObject
         lat = Double(l as! String)!
        let lo = data["lon"] as! NSObject
          lon = Double(lo as! String)!
        let distancee = data["distance"] as! NSObject
        distance =  distancee as! Double
     
    }
    
    
}
