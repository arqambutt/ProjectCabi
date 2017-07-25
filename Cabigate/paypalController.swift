//
//  paypalController.swift
//  Cabigate
//
//  Created by abdur rehman on 7/25/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


typealias contectUsT = (_ msg:String)-> Void

class contectUs {
    
    
    static var instance  = contectUs()
    static var object :contectUs {
        return instance
    }
    
    
    func contectUsFun(results:@escaping contectUsT){
        

        
          DispatchQueue.global(qos: .background).async {
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "companyid": "2100",
            "cache-control": "no-cache",
            "postman-token": "a2aa5667-c190-7728-f819-0a79ea033d31"
        ]
        
        
        let postData = "data={"+"\"companyid\""+":"+"\"2100\""+"}"
        
        let data = postData.data(using: .utf8)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/paymentinfo")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            
            
            
            if (error != nil) {
                
                
                return results("Authantication Error Please try later! Please cheak your Internet Connection")
                
                
            } else {
                
                
                do {
                    
                    
                    let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    
                  
                    let data = temp as NSDictionary
                    
                    let cheak = data.value(forKey: "status")!
                    
                    let cheakNow = String(describing: cheak)
                    
                    DispatchQueue.main.async {
                        if (cheakNow == "0"){
                            
                            return results("\(String(describing: data.value(forKey: "error_msg")!))")
                        }else {

                              let RESPONCE = temp["response"] as! NSDictionary

                            contectUsModal.object.paypal_email = String(describing: RESPONCE["paypal_email"] as! NSObject)
                            contectUsModal.object.contact_phone = String(describing: RESPONCE["contact_phone"] as! NSObject)
                            contectUsModal.object.contact_email = String(describing: RESPONCE["contact_email"] as! NSObject)
                            
                            
                            return results("")
                        }
                        
                    }
                }
                catch {
                    print(error)
                    
                }
            }
    
            
        })
        
        dataTask.resume()
       
        }
       
}
}
