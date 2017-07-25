//
//  FareEstimate.swift
//  Cabigate
//
//  Created by abdur rehman on 6/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


typealias fareEstime = (_ msg:String)-> Void

class fareEstimate {
    
    
    static var instance  = fareEstimate()
    static var object :fareEstimate {
        return instance
    }
    
    
    
    func fareEstimateFunction(taxiModel:String, Results:fareEstime?) {
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "companyid": "2100",
            "cache-control": "no-cache",
            "postman-token": "8f0d5c16-5ff5-73d1-0264-5e514669bb5a"
        ]
        
        let postData = "data={"+"\"userid\""+":"+"\"\(userData.object.uId)\""+","+"\"company_serial\""+":"+"\"2100\""+","+"\"current_location\""+":"+"\"\(booking.object.currentlocName)\","+"\"drop_location\""+":"+"\"\(booking.object.DeslocName)\""+","+"\"taxi_model\""+":"+"\(taxiModel)"+","+"\"pickup_lat\""+":"+"\"\(booking.object.picUpLat)\""+","+"\"pickup_lng\""+""+":"+"\"\(booking.object.picUpLon)\""+","+"\"drop_lat\""+":"+"\"\(booking.object.dropUpLat)\""+","+"\"drop_lng\""+":"+"\"\(booking.object.dropUpLon)\"}"
        
        
    
        
        let data = postData.data(using: .utf8)
        

        DispatchQueue.global(qos: .background).async {
            
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/calculatefare")! as URL,
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
                        
                        
                        if(cheakNow == "0"){
                            
                            let error = data["error_msg"] as! NSObject
                            
                            return Results!(error as! String)
                        }else {

                            
                            let RESPONCE = temp["response"] as! NSDictionary
                            
                            if let fare = RESPONCE.value(forKey: "max_luggage"){
                                
                                booking.object.max_luggage = fare as! String
                                
                                
                            }
                            if let fare = RESPONCE.value(forKey: "max_passenger"){
                                
                                booking.object.max_passenger = fare as! String
                                print(fare as! String)
                                
                            }
                            if let fare = RESPONCE.value(forKey: "total_duration"){
                                
                                booking.object.total_duration = fare as! String
                                
                                
                            }

                            if let fare = RESPONCE.value(forKey: "total_fare"){
                                
                        booking.object.fareEstimate = fare as! String
                                
   
                        }
                            
                            return Results!("")
                        }
                    }catch{
                        print(error)
                    }
                    }
                }
            
            
            
            
            
            
            
            
        })
        dataTask.resume()
    }
    }
}
