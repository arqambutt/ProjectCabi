//
//  FareEstimate.swift
//  Cabigate
//
//  Created by abdur rehman on 6/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


typealias fareEstime = (_ msg:String)-> Void

class fareEstimate {
    
    
    static var instance  = fareEstimate()
    static var object :fareEstimate {
        return instance
    }
    
}
