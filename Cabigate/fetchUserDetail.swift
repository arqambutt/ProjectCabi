//
//  fetchUserDetail.swift
//  Cabigate
//
//  Created by abdur rehman on 6/7/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

typealias fetchUserResults = (_ msg:String)-> Void

class fetchUserDetail{
    
    
    static var instance = fetchUserDetail()
    
    static var object :fetchUserDetail {
        
        return instance
    }
    
    
    
    func downloadUserDetail(results:@escaping fetchUserResults){
        
        DispatchQueue.global(qos: .background).async {
            
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "cache-control": "no-cache",
                "postman-token": "82c5c0c6-e966-8de2-bb6c-117ba8af267d"
            ]
            
            let postData = "data={"+"\"userid\""+":"+"\"1\""+","+"\"token\""+":"+"\"123456\""+"}"
            
            let data = postData.data(using: .utf8)
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/paxdetails")! as URL,
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
                        
                        print(temp)
                        
                        DispatchQueue.main.async {
                            
                        let errorcode = temp["status"]  as! NSObject
                        
                        if(String(describing: errorcode) == "0"){
                            
                            let error = temp["error_msg"] as! NSObject
                            
                            return results(error as! String)
                            
                        }else{
                            
                          
                                
                                let RESPONCE = temp["response"] as! NSDictionary
                               
                                if let email = RESPONCE.value(forKey:"email") {
                                    
                                    userDetail.object.email = email as! String
                                    
                                }
                                if let name = RESPONCE.value(forKey:"fname") {
                                    
                                    userDetail.object.fname = name as! String
                                    booking.object.fName = name as! String
                                }
                                
                                if let name = RESPONCE.value(forKey:"lname") {
                                    
                                    userDetail.object.lName = name as! String
                                }
                                
                                if let phone = RESPONCE.value(forKey:"phone") {
                                    
                                    userDetail.object.phone = phone as! String
                                }
                                
                                if let userid = RESPONCE.value(forKey:"userid"){
                                    
                                    userDetail.object.userid = userid as! String
                                    booking.object.uId = userid as! String
                                    
                                }
                            
                            
                            
                            if let userid = RESPONCE.value(forKey:"home_address"){
                                
                                userDetail.object.home_address = userid as! String
                               
                                
                            }
                            if let userid = RESPONCE.value(forKey:"home_lat"){
                                
                                userDetail.object.home_lat = userid as! String
                              
                                
                            }
                            if let userid = RESPONCE.value(forKey:"home_lng"){
                                
                                userDetail.object.home_lng = userid as! String
                                
                                
                            }
                            if let userid = RESPONCE.value(forKey:"work_address"){
                                
                                userDetail.object.work_address = userid as! String
                                
                                
                            }
                            if let userid = RESPONCE.value(forKey:"work_lat"){
                                
                                userDetail.object.work_lat = userid as! String
                                
                                
                            }
                            if let userid = RESPONCE.value(forKey:"work_lng"){
                                
                                userDetail.object.work_lng = userid as! String
                                
                                
                            }
                            
                                
                                if let userid = RESPONCE.value(forKey:"pax_photo"){
                                    
                                userDetail.object.profilePicUrl = userid as! String
                                }
                                
                                
                                return results("")
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
    func UpdatehomeAddress(homeName:String , Lat:String , lon:String , results: @escaping fetchUserResults){
        
        DispatchQueue.global(qos: .background).async {
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "cache-control": "no-cache",
                "postman-token": "54469ff7-efe7-ec00-a521-13cf1856169d"
            ]
            
            let postData = "data={"+"\"fname\""+":"+"\"\(userDetail.object.fname)\""+","+"\"lname\""+":"+"\"\(userDetail.object.lName)\""+","+"\"phone\""+":"+"\"\(userDetail.object.phone)\""+","+"\"password\""+":"+"\"dhaunkal12\""+", "+"\"token\""+":"+"\"123456\",\"userid\":\"1\","+"\"home_address\""+":"+"\"\(homeName)\""+","+"\"home_lat\""+":"+"\"\(Lat)\""+","+"\"home_lng\""+":"+"\"\(lon)\""+""+"}"
            
            let data = postData.data(using: .utf8)
            let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/updatepaxdetails")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    return results("Unable to Update your Information please Try Again!")
                    
                }   else{
                    
                    do {
                        
                        
                        
                        let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                        
                        
                        DispatchQueue.main.async {
                            print(temp)
                            
                            let errorcode = temp["status"]  as! NSObject
                            
                            if(String(describing: errorcode) == "0"){
                                
                                let error = temp["error_msg"] as! NSObject
                                
                                return results(error as! String)
                                
                            }else{
                                
                                return results("")
                                
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
    func UpdateWorkAddress(workName:String , Lat:String , lon:String , results: @escaping fetchUserResults){
        
        DispatchQueue.global(qos: .background).async {
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "cache-control": "no-cache",
                "postman-token": "54469ff7-efe7-ec00-a521-13cf1856169d"
            ]
            
            let postData = "data={"+"\"fname\""+":"+"\"\(userDetail.object.fname)\""+","+"\"lname\""+":"+"\"\(userDetail.object.lName)\""+","+"\"phone\""+":"+"\"\(userDetail.object.phone)\""+","+"\"password\""+":"+"\"dhaunkal12\""+", "+"\"token\""+":"+"\"123456\",\"userid\":\"1\","+"\"work_address\""+":"+"\"\(workName)\""+","+"\"work_lat\""+":"+"\"\(Lat)\""+","+"\"work_lng\""+":"+"\"\(lon)\""+""+"}"
            
            let data = postData.data(using: .utf8)
            let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/updatepaxdetails")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    return results("Unable to Update your Information please Try Again!")
                    
                }   else{
                    
                    do {
                        
                       
                        
                        let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                        
                        
                        DispatchQueue.main.async {
                            print(temp)
                            
                            let errorcode = temp["status"]  as! NSObject
                            
                            if(String(describing: errorcode) == "0"){
                                
                                let error = temp["error_msg"] as! NSObject
                                
                                return results(error as! String)
                                
                            }else{
                                
                                return results("")
                                
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
    
    func UpdateUserDetail( Uname:String , Pass:String,  LName:String , results: @escaping fetchUserResults){
        
        
        DispatchQueue.global(qos: .background).async {
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "cache-control": "no-cache",
                "postman-token": "54469ff7-efe7-ec00-a521-13cf1856169d"
            ]
            
            let postData = "data={"+"\"fname\""+":"+"\"\(Uname)\""+","+"\"lname\""+":"+"\"\(LName)\""+","+"\"phone\""+":"+"\"+923087033338\""+","+"\"password\""+":"+"\"\(Pass)\""+", "+"\"token\""+":"+"\"123456\",\"userid\":\"1\""+"}"
            
            let data = postData.data(using: .utf8)
            let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/updatepaxdetails")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    return results("Unable to Update your Information please Try Again!")
                    
                }   else{
                    
                    do {
                        
                        print(data!)
                        
                        let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                        
                        
                        DispatchQueue.main.async {
                            print(temp)
                            
                            let errorcode = temp["status"]  as! NSObject
                            
                            if(String(describing: errorcode) == "0"){
                                
                                let error = temp["error_msg"] as! NSObject
                                
                                return results(error as! String)
                                
                            }else{
                                
                                return results("")
                                
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
