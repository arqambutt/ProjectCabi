//
//  makeDefaultCard.swift
//  Cabigate
//
//  Created by abdur rehman on 6/14/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


typealias defaultOrNot = (_ msg:String)-> Void

class makeDefaultCard {
    
    
    static var instance = makeDefaultCard()
    
    static var object :makeDefaultCard {
        
        return instance
    }
    
    
    
    
    func MakeCardDefault( CardId:String , Results:@escaping defaultOrNot ){
        
        
        DispatchQueue.global(qos: .background).async {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "companyid": "2100",
            "cache-control": "no-cache",
            "postman-token": "9d038b62-caf3-4b52-a050-1a1a6f16f9ac"
        ]
        
            
            let postData = "data={"+"\"userid\""+":"+"\"1\""+","+"\"cardid\""+":"+"\"\(CardId)\""+","+"\"token\""+":"+"\"123456\"}"
            
            let data = postData.data(using: .utf8)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/makedefaultcard")! as URL,
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
