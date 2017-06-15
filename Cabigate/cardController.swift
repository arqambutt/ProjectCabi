//
//  VerificationController.swift
//  Cabigate
//
//  Created by abdur rehman on 6/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

typealias CardAddOrNot = (_ msg:String)-> Void


class Addcard{
    
    
    
    static var instance  = Addcard()
    static var object :Addcard {
        return instance
    }

    
    func performSavingCard( cardNumber:String , cvv:String , expiryMonth:String , expiryYear:String, Results:@escaping VerifyOrNot){
        
        
        let postData = "data={"+"\"userid\""+":"+"\"1\""+","+"\"exp_month\""+":"+"\"\(expiryMonth)\""+","+"\"exp_year\""+":"+"\"\(expiryYear)\""+", "+"\"number\""+":"+"\"\(cardNumber)\","+"\"cvc\""+":"+"\"\(cvv)\""+","+"\"token\""+":"+"\"123456\""+"}"
        
       
        
        let data = postData.data(using: .utf8)
        
        
        DispatchQueue.global(qos: .background).async {
            
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "companyid": "2100",
                "cache-control": "no-cache",
                "postman-token": "64100b60-3934-f162-524d-47fc64ed9625"
            ]
            
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/addcards")! as URL,
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
                        
                        let data = temp as NSDictionary
                        

                        let cheak = data.value(forKey: "status")!
                        
                        let cheakNow = String(describing: cheak)
                        
                        DispatchQueue.main.async {
                            
                            if (cheakNow == "0"){
                                
                                Results("\(String(describing: data.value(forKey: "error_msg")!))")
                                
                            }else {
                                
                           
                                let dataTwo = temp["response"] as! NSDictionary
                                
                                if let h = dataTwo.value(forKey: "msg") {
    
                                    print(h)
                                    
                                return  Results("")
                                    
                                }
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
