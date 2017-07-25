//
//  finalFeedbac.swift
//  Cabigate
//
//  Created by abdur rehman on 7/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation
typealias complain = (_ msg:Bool)-> Void

class Complainclass {
    
    
    static var instance  = Complainclass()
    static var object :Complainclass {
        return instance
    }
    
    
 
    
    func FetchHistory(jobId:String , needHelp:String,  Comment:String , results:@escaping complain){

  
            DispatchQueue.global(qos: .background).async {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "a20a6073-08a9-c794-7d9e-ab26660e28e2"
        ]
        
        
        
        let postData = "data={"+"\"job_id\""+":"+"\"\(jobId)\""+","+"\"userid\""+":"+"\"\(userDetail.object.userid)\""+","+"\"comment\""+":"+"\"\(Comment)\""+","+"\"needhelp_refrence\""+":"+"\"\(needHelp)\""+"}"
        
        let data = postData.data(using: .utf8)
        
        
       
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/reportproblem")! as URL,
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

                                return results(true)
                           
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
