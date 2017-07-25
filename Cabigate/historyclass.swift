//
//  historyclass.swift
//  Cabigate
//
//  Created by abdur rehman on 6/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


class historyclass{
    
    
    
    
    let pickup_datetime:String?
    let total_fare:String?
    
    let vehicle_image:String?
    let Username:String?
    let distance:String?
    let driver_image:String?
    let driver_phone:String?
    let driver_rating:String?
     let driver_name:String?
    let duration:String?
   
    let job_id:String?
    let passengers:String?
    let payment_method:String?
    let status:String?
    let taxi_model:String?
    let Callsign:String?
    let plate_number:String?
    
    
    let pickup_location:String?
    let drop_location:String?
    let pickup_lat:String?
    let pickup_lng:String?
    let drop_lat:String?
    let drop_lng:String?
    
    
    init(data:NSDictionary) {
       
        Callsign = String(describing: data["Callsign"] as! NSObject)
        pickup_lat = String(describing: data["pickup_lat"] as! NSObject)
        pickup_lng = String(describing: data["pickup_lng"] as! NSObject)
        drop_lat = String(describing: data["drop_lat"] as! NSObject)
        drop_lng = String(describing: data["drop_lng"] as! NSObject)
        total_fare = String(describing: data["total_fare"] as! NSObject)
        drop_location = String(describing: data["drop_location"] as! NSObject)
        pickup_location = String(describing: data["pickup_location"] as! NSObject)
        pickup_datetime = String(describing: data["pickup_datetime"] as! NSObject)
        vehicle_image = String(describing: data["vehicle_image"] as! NSObject)
        Username = String(describing: data["Username"] as! NSObject)
        distance = String(describing: data["distance"] as! NSObject)
        driver_image = String(describing: data["driver_image"] as! NSObject)
        driver_phone = String(describing: data["driver_phone"] as! NSObject)
        driver_rating = String(describing: data["driver_rating"] as! NSObject)
        duration = String(describing: data["duration"] as! NSObject)
        plate_number = String(describing: data["plate_number"] as! NSObject)
        job_id = String(describing: data["job_id"] as! NSObject)
        passengers = String(describing: data["passengers"] as! NSObject)
        payment_method = String(describing: data["payment_method"] as! NSObject)
        status = String(describing: data["status"] as! NSObject)
        taxi_model = String(describing: data["taxi_model"] as! NSObject)
        
          driver_name = String(describing: data["driver_name"] as! NSObject)
        
    }
    
    
    deinit {
        
    }
    
}
