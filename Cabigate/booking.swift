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
    var pic_Date:String = ""
    var texi_Modal:String = ""
    var picUpLat:String = ""
    var picUpLon:String = ""
    var payment :String = ""
    var dropUpLat:String = ""
    var dropUpLon:String = ""
    var fareEstimate:String = ""
    var max_luggage:String = ""
    var max_passenger:String = ""
    var total_duration:String = ""
    var RideNowBtnPress:Bool = false
    var paypalPass = false
    
  
}
