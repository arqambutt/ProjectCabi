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
    var eta_time:Int = 0
    var MarkerPic:String = ""
    
    
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
        
        let MarkerPicc = data["icon"] as! NSObject
        MarkerPic =  MarkerPicc as! String
     
        let eta = data["eta_time"] as! NSObject
        eta_time =  eta as! Int
    
     
    }
    
    
    
    init(driver_id:String, taxi_model:String, driver_name:String , phone:String,taxi_color:String ,taxi_type:String, eta_time:Int,MarkerPic:String   ) {
        

        self.driver_id = driver_id
        self.taxi_model = taxi_model
        self.driver_name = driver_name
        self.phone = phone
        self.taxi_color = taxi_color
        self.taxi_type = taxi_type
        self.eta_time = eta_time
        self.MarkerPic = MarkerPic
        
    }
    
    
}
