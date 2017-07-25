//
//  DriverDetailModel.swift
//  Cabigate
//
//  Created by abdur rehman on 6/22/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation



class DriverDetailInit {
    
    var jobid = ""
    var status = ""
    var pickup = ""
    var pickup_lat = ""
    var pickup_lng = ""
    var dropoff_lat = ""
    var dropoff_lng = ""
    var driver_id = ""
    var driver_lat = ""
    var driver_lng = ""
    var driver_name = ""
    var driver_contact = ""
    var driver_image = ""
    var driver_rating = ""
    var vehicle_id = ""
    var vehicle_name = ""
    var vehicle_model = ""
    var vehicle_plate = ""
    var vehicle_image = ""
    var dropoff = ""
   
 
    init(object:[String: String]) {
        
        if  let a = object["driver_lat"]{
            
            self.driver_lat =  a
        }
        
        
        if let b = object["driver_lng"] {
            self.driver_lng = b
        }

        
        if  let a = object["driver_image"]{
            
          self.driver_image =  a 
        }
        
        
        if let b = object["status"] {
        self.status = b
        }
        
        if let c = object["pickup"] {
        self.pickup = c

        }
        
        if let c = object["dropoff"] {
            
            self.dropoff = c
        }
        if let job = object["jobid"] {
            self.jobid = job
            
        }
  
        if let e = object["pickup_lat"] {
        self.pickup_lat = e
        }
    
        if let f = object["pickup_lng"] {
        self.pickup_lng = f
        }
        
        if let g = object["dropoff_lat"] {
        self.dropoff_lat = g
        }
        
        if let h = object["dropoff_lng"] {
        self.dropoff_lng = h
        }
        
        if let i = object["driver_id"] {
        self.driver_id = i
        }
        
        if let j = object["driver_name"] {
        self.driver_name = j
        }
        
        if let k = object["driver_contact"] {
        self.driver_contact = k
        }
        
        if let l = object["driver_image"] {
        self.driver_image = l
        }

        if let m = object["driver_rating"] {
        self.driver_rating =  m
        }
        
        if let n = object["vehicle_id"] {
        self.vehicle_id = n
        }
        
        if let o = object["vehicle_name"] {
        self.vehicle_name = o
        }
        
        if let p = object["vehicle_model"] {
        self.vehicle_model = p
        }
        
        if let q = object["vehicle_plate"] {
        self.vehicle_plate = q
        }
        
        if let r = object["vehicle_image"] {
        self.vehicle_image = r
        }
   
        
    }
    
   
    
}
