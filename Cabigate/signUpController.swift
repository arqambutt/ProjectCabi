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
                           
                        } else {
                            
                            do {
                               
                                
                                let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                                
                                let data = temp as NSDictionary
                                
                                let cheak = data.value(forKey: "status")!
                                
                                let cheakNow = String(describing: cheak)

                                
                                DispatchQueue.main.async {
                                  
                                    if (cheakNow == "0"){
                                        
                                        Results("Unable to verify your mobile number")
                                        
                                    }else {
                                    
                                      
                                        let dataTwo = temp["response"] as! Dictionary<String,String>
                                        
                                        
                                        print(dataTwo)
                                        
                                        
                                        if let h = dataTwo["userid"] {
                                            
                                            userData.object.uId = h
                                            
                                        }
                                        if let h = dataTwo["token"] {
                                            
                                            userData.object.token = h
                                        }
                                       
                                        if let h = dataTwo["fname"]{
                                            
                                            userData.object.fName = h
                                        }
                                        if let h = dataTwo["OPT"]{
                                            
                                            userData.object.OPT = h
                                        }
                                        if let h = dataTwo["keymatch"] {
                                            
                                            userData.object.keymatch = h
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



    
