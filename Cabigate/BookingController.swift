//
//  BookingController.swift
//  Cabigate
//
//  Created by abdur rehman on 6/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation



typealias Booking = (_ msg:String)-> Void

class bookingClass {
    
    
    static var instance  = bookingClass()
    static var object :bookingClass {
        return instance
}
    
    func bookingFunction(Results:@escaping Booking){
    
        
       
        
        
        
        
        
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "companyid": "2100",
        "cache-control": "no-cache",
        "postman-token": "1f9efb59-7ecf-82bf-5319-60397e08b53d"
    ]
        
    let postData = "data={"+"\"passenger_id\""+":"+"\"\(booking.object.uId)\""+","+"\"firstname\""+":"+"\"\(booking.object.fName)\""+","+"\"current_location\""+":"+"\"\(booking.object.currentlocName)\","+"\"drop_location\""+":"+"\"\(booking.object.DeslocName)\""+","+"\"pax_count\""+":"+"\(booking.object.max_passenger)"+","+"\"pickup_date\""+":"+"\"\(booking.object.pic_Date)\""+","+"\"taxi_model\""+":"+"\(booking.object.texi_Modal)"+","+"\"pickup_lat\""+":"+"\"\(booking.object.picUpLat)\""+","+"\"pickup_lng\""+":"+"\"\(booking.object.picUpLon)\""+","+"\"drop_lat\""+":"+"\"\(booking.object.dropUpLat)\""+","+"\"drop_lng\""+":"+"\"\(booking.object.dropUpLon)\""+","+"\"payment_method\""+":"+"\"\(booking.object.payment)\","+"\"total_fare\""+":"+"\"\(booking.object.fareEstimate)\"}"
    

        let data = postData.data(using: .utf8)
        
        
        DispatchQueue.global(qos: .background).async {
        
    let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/addbooking")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = data
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
       
        
        
        if (error != nil) {
            print(error!)
        } else {
            
            DispatchQueue.main.async {
                do {
                    
                    let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    
                    let data = temp as NSDictionary
                    
                    print(data)
                    
                    let cheak = data.value(forKey: "status")!
                    
                    let cheakNow = String(describing: cheak)
                    
                    print(cheakNow)
                    if(cheakNow == "0"){
                        
                        let error = data["error_msg"] as! NSObject
                        
                        return Results(error as! String)
                    }else {
                        
                        
                        let RESPONCE = temp["response"] as! NSDictionary
                        
                    
                        print(RESPONCE)
                        
                        
                        return Results("")
                    }
                }catch{
                   return Results("No")
                }
            }
        }
        
        
   
        
        
    })
    
    dataTask.resume()
        
 
    }
        
    }

}

