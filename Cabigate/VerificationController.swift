//
//  VerificationController.swift
//  Cabigate
//
//  Created by abdur rehman on 6/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

typealias VerifyOrNot = (_ msg:String)-> Void


class VerifyMyNumber{
    
    
    
    static var instance  = VerifyMyNumber()
    static var object :VerifyMyNumber {
        return instance
    }
    
    
    
    func PerformVerification( Code:String  , Results:@escaping VerifyOrNot){
        
        let codeTWo = userData.object.OPT + Code
        
        print(codeTWo)
        let postData = "data={"+"\"userid\""+":"+"\"\(userData.object.uId)\""+","+"\"keymatch\""+":"+"\"\(userData.object.keymatch)\""+","+"\"OPT\""+":"+"\"\(codeTWo)\""+""+","+"\"token\""+":"+"\"\(userData.object.token)\""+"}"
        
        
        print(postData)
        
        
        
        let data = postData.data(using: .utf8)
        
        
        DispatchQueue.global(qos: .background).async {

        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "companyid": "2100",
            "cache-control": "no-cache",
            "postman-token": "121e6e15-ae58-875b-7f15-2b6218b4d1c5"
        ]
        
       
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/verifyphone")! as URL,
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
               
                print(data!)
                do {
                    
                    let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    
                    let data = temp as NSDictionary
                
                    print(data)
                    let cheak = data.value(forKey: "status")!
                    
                    let cheakNow = String(describing: cheak)
                    
                    DispatchQueue.main.async {
                    
                    if (cheakNow == "0"){
                        
                       Results("Aoory you have Entered Wrong Verification Number")
                        
                    }else {
                        
                
                            
                            let dataTwo = temp["response"] as! NSDictionary
                            
                         if let h = dataTwo.value(forKey: "userid") {
                                
                                userData.object.uId  = h as! String
                            }
                            if let h = dataTwo.value(forKey: "token") {
                                
                                userData.object.token = h as! String
                            }

            UserDefaults.standard.set("\(userData.object.token)", forKey: "token")
                        
            UserDefaults.standard.set("\(userData.object.uId)", forKey: "UID")
                        
                        

                        
                            return  Results("")
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
}
