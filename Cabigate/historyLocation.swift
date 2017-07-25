//
//  historyLocation.swift
//  Cabigate
//
//  Created by abdur rehman on 6/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

typealias ImportorNot = (_ msg:Bool)-> Void

class ImportHistory {
    
    
    static var instance  = ImportHistory()
    static var object :ImportHistory {
        return instance
    }
    
    deinit {
        
    
    }
  
    
     static var historyArray = [historyclass]()
   
    
    func FetchHistory(results:@escaping ImportorNot){
       
        ImportHistory.historyArray.removeAll()
      
      
            
              DispatchQueue.global(qos: .background).async {
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "companyid": "2100",
                "cache-control": "no-cache",
                "postman-token": "eb47cc15-7723-7fe9-3461-edcacbf7fe74"
            ]
            let postData = "data={"+"\"userid\""+":"+"\"1\""+","+"\"token\""+":"+"\"xyz123456\""+","+"\"type\""+":"+"\"all\""+"}"
            
            let data = postData.data(using: .utf8)
            
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/jobhistory")! as URL,
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
                               
                                
                                  ImportHistory.historyArray.append(historyclass.init(data: i as! NSDictionary))

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
