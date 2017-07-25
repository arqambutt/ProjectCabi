//
//  nearestDriverController.swift
//  Cabigate
//
//  Created by abdur rehman on 6/4/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation
import SocketIO


typealias FetchSucess = (_ msg:Bool)-> Void
typealias SocketTriger = (_ msg:String)-> Void




class nearestDriverController{
    
   
    
     var socketInstance:SocketIOClient?
    
    static var instance  = nearestDriverController()
    static var object :nearestDriverController {
        return instance
    }

    static var nearestdriver:socketDriver? 
    static var DriverCsTATUS:DriverDetailInit?
    
    static var ANearestDriver = [NDCLASS]()
    
    
    func nearestDriver(Results:@escaping FetchSucess) {
        
        nearestDriverController.ANearestDriver.removeAll()
        
        DispatchQueue.global(qos: .background).async {
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "4823b407-b691-8a67-b25c-c7ef9c43ec33"
        ]
        
        let postData = "data={"+"\"lat\""+":"+"\"51.5051300\""+","+"\"lng\""+":"+"\"-0.1264762\""+"}"
        
        let data = postData.data(using: .utf8)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/nearestdrivers")! as URL,
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
                   
                    
                    let data = temp["response"] as! NSDictionary
                    
                let array  = data["list"] as! NSArray
                    
                    DispatchQueue.main.async {
 
                    for i in array  {

                    
                        nearestDriverController.ANearestDriver.append(NDCLASS.init(data: i as! Dictionary<String,String>))
               
                       
                    }
                        
                        
                        return Results(true)
                        
                    }
                  
                    
                }catch{
                    print(error)
                }
            }
        })
        
        dataTask.resume()
        
        
        }
    }
    
    
    
    
    func SocketRequest(Socket:@escaping SocketTriger){
        

                    socketInstance = SocketIOClient(socketURL: URL(string: "http://cabigate.com:3000")!, config: [.log(true), .forcePolling(true)])
                    
                    socketInstance?.on(clientEvent: .connect) {data, ack in
                        
                    
                        
                        
                      
    self.socketInstance?.emit("senddata", ["user_id": "1", "type": "passenger", "username": "Arehman"])
                    }
                    
    
                    socketInstance?.on("locationupdater") {data, ack in
                        if let cur = data[0] as? NSDictionary  {
                            

                           
                        nearestDriverController.nearestdriver = socketDriver.init(object:cur )

                           
                           
                        return Socket("")
                            

                        }
                        return Socket("No")
                    }

                    
                    
                    
                    socketInstance?.on("passenger_notifier") {data, ack in
                        if let cur = data[0] as?  [String: Any]  {
                           
                          
                       
                            
                    if let y = cur["details"] as? [String: String] {
                                
                      
                nearestDriverController.DriverCsTATUS = DriverDetailInit.init(object: y)

                        
                            }
                         
                            
                            return Socket("Driver")
                         
                            
                        }
                       return Socket("No")
                    }
                    
                    
                    socketInstance?.connect()
                    
   
}
}

    
    
    

