//
//  defaultsettings.swift
//  Cabigate
//
//  Created by abdur rehman on 6/4/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation



class defaultSettings {
    
    static var instance = defaultSettings()
    static var object:defaultSettings {
        
        return instance
    }
    
    
    var companyId:String = "2100"
    var method:String = "fb"
    
}
