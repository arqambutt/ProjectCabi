//
//  vehacialList.swift
//  Cabigate
//
//  Created by abdur rehman on 7/22/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

typealias list = (_ msg:String)-> Void
class VehacialList {
    
    
    static var instance  = VehacialList()
    static var object :VehacialList {
        return instance
}

     static var VehacialListArray = [VehacialListModal]()
    
    func FetchVehacial(  lat:String , lon:String , nearestArray:[String],                     result:@escaping list) {
    
        VehacialList.VehacialListArray.removeAll()
    
    DispatchQueue.global(qos: .background).async {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "4221f1da-da99-03db-6a9b-4b18a21348d1"
        ]
        

        let postData =
            "data={"+"\"lat\""+":"+"\"52.33301\""+","+"\"lng\""+":"+"\"-32.222222\""+"}"
        
        
        let data = postData.data(using: .utf8)

        
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/vehicleslist")! as URL,
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
                            
                            return result("\(String(describing: data.value(forKey: "error_msg")!))")
                            
                        }else {
                            let data = temp["response"] as! NSDictionary
                            
                            let array  = data["list"] as! NSArray
                            
                            DispatchQueue.main.async {
                                
                                for i in array  {
                                    
                                    let obj = VehacialListModal.init(data: i as! NSDictionary)
                                    let Boolion =  nearestArray.contains(obj.typeid)
                                    
                                    if (Boolion == true){
                                       
                                         VehacialList.VehacialListArray.append(obj)
                                        
                                    }else {
                                       
                                        
                                    }
                                  
                                }
                                
                                return result("")
                                
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
    
