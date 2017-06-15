//
//  visaCardController.swift
//  Cabigate
//
//  Created by abdur rehman on 6/14/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

typealias DeleteOrNot = (_ msg:String)-> Void

class deleteVisaCard{
    
    
    static var instance = deleteVisaCard()
    
    static var object :deleteVisaCard {
        
        return instance
    }
    
   
    
    
    func fetcAllCard( CarId:String , Results:@escaping cardResult ){
        
        
        
        DispatchQueue.global(qos: .background).async {
            
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "companyid": "2100",
                "cache-control": "no-cache",
                "postman-token": "c88608f5-e2ad-0031-1305-74fc3b5b6f73"
            ]
            
            let postData = "data={"+"\"userid\""+":"+"\"1\""+","+"\"cardid\""+":"+"\"\(CarId)\""+","+"\"token\""+":"+"\"123456\"}"
            
            let data = postData.data(using: .utf8)
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/deletecard")! as URL,
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
                            
                            let cheak = data.value(forKey: "status")!
                            
                            let cheakNow = String(describing: cheak)
                            
                            if (cheakNow == "0"){
                                
                                return Results("\(String(describing: data.value(forKey: "error_msg")!))")
                                
                            }else {
                                
                             
                                    return Results("")
                                    
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
