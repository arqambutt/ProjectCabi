//
//  booking.swift
//  Cabigate
//
//  Created by abdur rehman on 6/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


class booking {
    
    static var instance = booking()
    static var object:booking {
        
        return instance
    }
    
    var uId:String = ""
    var fName:String = ""
    var currentlocName:String = ""
    var DeslocName :String = ""
    var pax_Count:String = ""
    var pic_Date:NSData? = nil
    
    var text_Modal:String = ""
    var picUpLat:Double = 0.0
    var picUpLon:Double = 0.0
    var payment :String = ""
    var dropUpLat:Double = 0.0
    var dropUpLon:Double = 0.0
     var tottleFare:String = ""
    
    
}
