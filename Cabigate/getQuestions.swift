//
//  getQuestions.swift
//  Cabigate
//
//  Created by abdur rehman on 7/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


class qAModal {
    
    
    let details:String?
    let ID:String?
    let feedback_enable:String?
    let heading:String?
    
    
    
    init(data:NSDictionary) {
        
        details = String(describing: data["details"] as! NSObject)
        ID = String(describing: data["ID"] as! NSObject)
        feedback_enable = String(describing: data["feedback_enable"] as! NSObject)
        heading = String(describing: data["heading"] as! NSObject)
        
        }
    
    deinit {
        print("denint")
    }
    
}
