//
//  signUpController.swift
//  Cabigate
//
//  Created by abdur rehman on 6/4/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

typealias metadataSignUp = (_ msg:String)-> Void

class signUpController {

    
    static var instance  = signUpController()
    static var object :signUpController {
        return instance
    }
    
    //"data={"+"\"fname\""+":"+"\"test\""+","+"\"lname\""+":"+"\"test\""+","+"\"phone\""+":"+"\"+910123409089\""+","+"\"password\""+":"+"\"123456\""+", "+"\"email\""+":"+"\"passenger@cabigate.com\""+"}"
    
    
    func signUP(name:String , email:String , pNumber:String , pass:String , Results:@escaping metadataSignUp){
        
        
        
        if(name == "" || email == "" || pNumber == "" || pass == ""){
            
        return Results("Empty Fields")
            
        }else {
            
        
            let verifyEmail = signinController.object.isValidEmailAddress(emailAddressString: email)
            
            if (verifyEmail == false){
                
                return Results("Email is not valid ")
                
            }else {
                
                  DispatchQueue.global(qos: .background).async {
                    let headers = [
                        "content-type": "application/x-www-form-urlencoded",
                        "cache-control": "no-cache",
                        "postman-token": "0072d7e8-fc78-7b2a-91fe-3263d53ae9e4"
                    ]
                    
                
                let postData = "data={"+"\"fname\""+":"+"\"\(name)\""+","+"\"lname\""+":"+"\"\(name)\""+","+"\"phone\""+":"+"\"\(pNumber)\""+","+"\"password\""+":"+"\"\(pass)\""+", "+"\"email\""+":"+"\"\(email)\""+"}"
                
              
                
                let data = postData.data(using: .utf8)
                
                    let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/signup")! as URL,
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
                                
                                print(data!)
                                
                                let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                                
                                let chapi = temp as NSDictionary
                               
                                let errorcode = temp["status"]  as! NSObject
                               
                                 DispatchQueue.main.async {
                                    
                                if(String(describing: errorcode) == "0"){
                                    
                                    Results("\(String(describing: chapi.value(forKey: "error_msg")!))")
                                    
                                }else{
                                    
                                        
                                        let dataTwo = temp["response"] as! NSDictionary
                                        
                                        if let h = dataTwo.value(forKey: "companyid") {
                                            
                                            defaultSettings.object.companyId = h as! String
                                        }
                                        if let h = dataTwo.value(forKey: "fname") {
                                            
                                            userData.object.fName = h as! String
                                        }
                                        if let h = dataTwo.value(forKey: "userid") {
                                            
                                            userData.object.uId  = h as! String
                                            
                                            print(h)
                                        }
                                        if let h = dataTwo.value(forKey: "token") {
                                            
                                            userData.object.token = h as! String
                                        }
                                        if let h = dataTwo.value(forKey: "OPT") {
                                            
                                            userData.object.OPT = h as! String
                                        }
                                        if let h = dataTwo.value(forKey: "keymatch") {
                                            
                                            userData.object.keymatch = h as! String
                                        }
                                
                                    
                                    UserDefaults.standard.set("\(userData.object.token)", forKey: "token")
                                      UserDefaults.standard.set("\(userData.object.fName)", forKey: "fname")
                                    UserDefaults.standard.set("\(userData.object.uId)", forKey: "UID")
                                        
                                         return Results("")
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
            }
            
            
        }
        
        
        
        
        
    }



    
