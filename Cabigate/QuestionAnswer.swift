//
//  QuestionAnswer.swift
//  Cabigate
//
//  Created by abdur rehman on 7/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation



typealias qusFetch = (_ msg:Bool)-> Void

class Ques {
    
    
    static var instance  = Ques()
    static var object :Ques {
        return instance
    }
    
    deinit {
        
    }
    
   static var QuestionAnswe = [qAModal]()
    
    
    func FetchQuest(results:@escaping qusFetch){
        
        
        Ques.QuestionAnswe.removeAll()
       
        
        DispatchQueue.global(qos: .background).async {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "2503c05e-4f81-30c5-50be-04bdb9a33625"
        ]
            
        
        let postData = "data={"+"\"passenger_id\""+":"+"\"\(userDetail.object.userid)\""+"}"
        
        let data = postData.data(using: .utf8)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/needhelp")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                
            } else {
                
                DispatchQueue.main.async {
                    do {
                        
                        let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                        
                        let data = temp as NSDictionary
                        
                        let cheak = data.value(forKey: "status")!
                        
                        let cheakNow = String(describing: cheak)
                        
                        if (cheakNow == "0"){
                            
                            return results(false)
                        }else {
                            
                            
                            let data = temp["response"] as! NSDictionary
                            
                            let array  = data["list"] as! NSArray
                            
                            DispatchQueue.main.async {
                                
                                for i in array  {
                                    
                                    
                             Ques.QuestionAnswe.append(qAModal.init(data: i as! NSDictionary))
                                    
                                    
    
                                    
                                }
                                
                                
    
                                return results(true)
                                
                            }
                            
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
