//
//  changePhonenUmber.swift
//  Cabigate
//
//  Created by abdur rehman on 7/13/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

typealias Response = (_ msg:String)-> Void

class changePhoneNumber {
    
    
    static var instance  = changePhoneNumber()
    static var object :changePhoneNumber {
        return instance
}
    
    
    func verifyPhoneNumber(phonenumber:String , result:@escaping Response) {
        
        
        
  
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "cache-control": "no-cache",
        "postman-token": "6f65f5b4-0650-606c-3ecd-05459dc9f309"
    ]
    
     let postData = "data={"+"\"userid\""+":"+"\"\(userData.object.uId)\""+","+"\"phone\""+":"+"\"\(phonenumber)\""+"}"
    
        
        
        
        
        let data = postData.data(using: .utf8)
        
        
        
    let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/phoneupdate")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody =  data
    
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
                        
                        result ("no")
                        
                    }else {
                        
  
                        let dataTwo = temp["response"] as!  Dictionary<String,String>
                        
                        
                        print(dataTwo)
                        if let h = dataTwo["OPT"]{
                            
                            userData.object.OPT = h
                        }
                        if let h = dataTwo["keymatch"] {
                            
                            userData.object.keymatch = h
                        }
                        if let h = dataTwo["token"] {
                            
                            userData.object.token = h
                        }
     
                        
                        return  result("")
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
