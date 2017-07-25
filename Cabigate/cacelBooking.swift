//
//  cacelBooking.swift
//  Cabigate
//
//  Created by abdur rehman on 7/11/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

typealias cancelBooking = (_ msg:Bool)-> Void
class CacnelBooking {
    
    
    static var instance  = CacnelBooking()
    static var object :CacnelBooking {
        return instance
    }
   

    func cancelapi(jobId:String,  Resion:String ,result:@escaping cancelBooking){
    
 
        
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "cache-control": "no-cache",
        "postman-token": "6a2ec526-945f-e755-c015-72e23e8365c1"
    ]
    
    let postData = "data={"+"\"userid\""+":"+"\"\(userData.object.uId)\""+","+"\"jobid\""+":"+"\"\(jobId)\""+","+"\"reason\""+":"+"\"\(Resion)\""+","+"\"token\""+":"+"\"\(userData.object.token)\""+","+"\"companyid\""+":"+"\"2100\"}"
  
    let data = postData.data(using: .utf8)
    
    let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/canceljob")! as URL,
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
            
            
            do {
                
                let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                
                let data = temp as NSDictionary
                
                let cheak = data.value(forKey: "status")!
                
                let cheakNow = String(describing: cheak)
                
                DispatchQueue.main.async {
                    
                    if (cheakNow == "0"){
                        
                        result(false)
                        
                    }else {
                     
                        return result(true)
                    }
                }

                
                
            }catch {
                print(error)
            }
            
            
            
        }
    })
    
  
    dataTask.resume()
}

    
}

