//
//  signInController.swift
//  Cabigate
//
//  Created by abdur rehman on 6/3/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

typealias metadata = (_ msg:String)-> Void

class signinController {
    
 
    static var instance  = signinController()
    static var object :signinController {
        return instance
    }
    
    
    func signIn(companiId:String , email:String, password:String , method:String , results:@escaping metadata){
        
        
        
        if(email == "" || password == "" ){
            
            return results("Empty Fields")
            
        }
        else {
            
            let verifyEmail = isValidEmailAddress(emailAddressString: email)
            
            if (verifyEmail == false){
                
                return results("Email is not valid ")
                
            }else {
                
            
            
            
            DispatchQueue.global(qos: .background).async {
                
                let headers = [
                    "content-type": "application/x-www-form-urlencoded",
                    "cache-control": "no-cache",
                    "postman-token": "4cdcbe06-99c8-62b4-e254-d86d42679e7b"
                ]
                
                
                //        let companiiD = 2100
                //        let email = "ghunny_shari@yahoo.com"
                //        let password = "123456789"
                //        let method = "normal"
                
                let postData = "data={"+"\"companyId\""+":"+"\"\(companiId)\""+","+"\"email\""+":"+"\"\(email)\""+","+"\"password\""+":"+"\"\(password)\""+","+"\"auth\""+":"+"\"\(method)\""+"}"
                
                let data = postData.data(using: .utf8)
                
                let request = NSMutableURLRequest(url: NSURL(string: "https://paxapi.cabigate.com/index.php/signin")! as URL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headers
                request.httpBody = data
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    
                    
                    if (error != nil) {
                        
                        
                        return results("Authantication Error Please try later! Please cheak your Internet Connection")
                      
                        
                    } else {
                        
                        do {
                            
                            let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                            
                            let data = temp as NSDictionary
                            
                            let cheak = data.value(forKey: "status")!
                            
                            let cheakNow = String(describing: cheak)
                             DispatchQueue.main.async {
                            
                            if (cheakNow == "0"){
                                
                              return results("\(String(describing: data.value(forKey: "error_msg")!))")
                            }else {
                                
                               
                                 
                                    let dataTwo = temp["response"] as! NSDictionary
                                    
                                    if let h = dataTwo.value(forKey: "companyid") {
                                        
                                        defaultSettings.object.companyId = h as! String
                                    }
                                    if let h = dataTwo.value(forKey: "fname") {
                                        
                                        userData.object.fName = h as! String
                                    }
                             
                                    if let h = dataTwo.value(forKey: "userid") {
                                        
                                        userData.object.uId  = h as! String
                                    
                                    }
                                    if let h = dataTwo.value(forKey: "token") {
                                        
                                        userData.object.token = h as! String
                                    }
                                
                                UserDefaults.standard.set("\(userData.object.token)", forKey: "token")
                                UserDefaults.standard.set("\(userData.object.fName)", forKey: "fname")
                                UserDefaults.standard.set("\(userData.object.uId)", forKey: "UID")
                                
                                      return results("")
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
        

    }
    
    
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        // Regular Expression Check
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            //Set Rules
            let regex = try NSRegularExpression(pattern: emailRegEx)
            
            // TypeCasting -> NSString to use specifil function .Length
            let nsString = emailAddressString as NSString
            
            
            // formula to find validity of email
            let results = regex.matches(in:emailAddressString, range: NSRange(location: 0,length: nsString.length))
            
            if results.count == 0
            {
                //Error
                returnValue = false
            }
        }
        catch let error as NSError
        {
            print("invalid regex: \(error.localizedDescription)")
            
        }
        
        return returnValue
    }

    
    
    
   
    
    
    
    
    
    
    
    
    
}
