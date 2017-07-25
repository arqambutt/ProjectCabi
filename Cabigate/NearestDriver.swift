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
    
    
    init(data:Dictionary<String,String>) {
        
        if let Cs = data["company_serial"]{
          
        company_serial = String(describing: Cs)
        }
   
        
        
        
        if let Di = data["driver_id"] {
         
             driver_id = String(describing: Di)
        }
     
        
        
        
        if let Tm = data["taxi_model"] {
            
           taxi_model = String(describing: Tm)
        }
      
        
        
        if let DN = data["driver_name"]{
            
             driver_name = String(describing: DN)
        }
       
        
   
        
        if let p = data["phone"]{
              phone = String(describing: p)
            
        }
      
        
        
        if let CS = data["Callsign"] {
           
             Callsign = String(describing: CS)
        }
       
        
        
        if let Tc = data["taxi_color"] {
          
        taxi_color = String(describing: Tc)
            
        }
  
        
        if let TT = data["taxi_type"] {
          taxi_type = String(describing: TT)
        }
        
        
        if let l = data["lat"] {
            
            lat = Double(l)!
        }
        
        
        if let lo = data["lon"]{
            
               lon = Double(lo)!
        }
       
        
      
        if let distancee = data["distance"]{
            
            distance =  Double(distancee)!
        }
    
        
        if let MarkerPicc = data["icon"]{
            
              MarkerPic =  MarkerPicc
        }
      

        if let eta = data["eta_time"] {
            
            
            eta_time =  Int(eta)!
        }
    
     
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
    
//    deinit {
//        print("deinit")
//    }
    
}
