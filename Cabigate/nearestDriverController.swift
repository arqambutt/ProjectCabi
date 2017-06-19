//
//  nearestDriverController.swift
//  Cabigate
//
//  Created by abdur rehman on 6/4/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation
import SwiftSocket
import SocketIO


typealias FetchSucess = (_ msg:Bool)-> Void
typealias SocketTriger = (_ msg:String)-> Void

class nearestDriverController{
    
    
    static var instance  = nearestDriverController()
    static var object :nearestDriverController {
        return instance
    }
    
    var object:socketDriver? = nil
    
    static var ANearestDriver = [NDCLASS]()
    
    
    func nearestDriver(Results:@escaping FetchSucess) {
        
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
        
            // do stuff 42 seconds later
        
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
                        
                    
                        
                        
                    let responce = NDCLASS.init(data: i as! NSDictionary)
                      
                    
                        nearestDriverController.ANearestDriver.append(responce)
                    
                       
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
        
        let postData = "{"+"\"user_id\""+":"+"\"1234\""+","+"\"type\""+":"+"\"passenger\""+","+""+"\"username\""+":"+"\"AGS\""+"}"

        
        print(postData)
        let temp = postData.data(using: .utf8)
        
        print(temp!)
        let dic:NSDictionary = ["user_id": "786", "type": "passenger", "username": "AGSsdasd"]
        

        do {
            
            
            if let json = try? JSONSerialization.data(withJSONObject: dic, options: []) {
                // here `json` is your JSON data, an array containing the String
                // if you need a JSON string instead of data, then do this:
                if let content = String(data: json, encoding: String.Encoding.utf8) {
                    // here `content` is the JSON data decoded as a String
                    print(content)
                    
                    
                    let socket = SocketIOClient(socketURL: URL(string: "http://cabigate.com:3000")!, config: [.log(true), .forcePolling(true)])
                    
                    socket.on(clientEvent: .connect) {data, ack in
                        
                    
                        
                        
                      
    socket.emit("senddata", ["user_id": "786", "type": "passenger", "username": "Arehman"])
                    }
                    
                    
                    
               
                    
                    
                    socket.on("locationupdater") {data, ack in
                        if let cur = data[0] as? NSDictionary {
                            
                            self.object =  socketDriver.init(object:cur  as NSDictionary)
                            
                            return Socket("")
                           

                        }
                        return Socket("No")
                    }

                    socket.connect()
                    

                    
                    
                    
                    
                    
                    
                    
                }
            }
            
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            
            print(jsonData)
            // here "jsonData" is the dictionary encoded in JSON data
            
            let decoded = try JSONSerialization.jsonObject(with: temp!, options:.allowFragments)
            // here "decoded" is of type `Any`, decoded from JSON data
            print(decoded)
            // you can now cast it with the right type
            if decoded is [String:String] {
                // use dictFromJSON
               
                
                
            }
        } catch {
            print(error.localizedDescription)
        }
       
        
    
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
