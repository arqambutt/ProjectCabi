//
//  ratingClass.swift
//  Cabigate
//
//  Created by abdur rehman on 7/12/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation



typealias rated = (_ msg:String)-> Void

class rating {
    
    
    
    static var instance  = rating()
    static var object :rating {
        return instance
}


    func rateDriver( rating:String , cOMMENT:String, result:@escaping rated){
        
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "b89642f1-0419-c322-920a-f4f0ec6c5c1f"
        ]
        
        let postData = "data={"+"\"job_id\""+":"+"\"1\""+","+"\"userid\""+":"+"\"9\""+","+"\"rating\""+":"+"\"\(rating)\""+","+"\"comment\""+":"+"\"\(cOMMENT)\""+"}"
        
        let data = postData.data(using: .utf8)
        
      
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/rateandpay")! as URL,
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
                    
                    print(temp)
                    
                    let errorcode = temp["status"]  as! NSObject
                    
                    if(String(describing: errorcode) == "0"){
                        
                        let error = temp["error_msg"] as! NSObject
                        
                        return result(error as! String)
                        
                    }else{
                        
                        DispatchQueue.main.async {
 
                            return result("")
                        }
                        
                    }
                    
                    
                }catch{
                    print(error)
                }
            }
        })
        
        dataTask.resume()
        
        
        
    }
    
    

}


    
