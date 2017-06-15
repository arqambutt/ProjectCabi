//
//  Alert.swift
//  Cabigate
//
//  Created by abdur rehman on 6/4/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation
import UIKit

class alert {
    
    
    static var instance = alert()
    static var object :alert {
    
        return instance
    }
    
    
    
    func alertForSignin(title:String , message:String)->UIAlertController{
        
        
        let message = UIAlertController(title:title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let Action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive) { (UIAlertAction) in
            
        }
        
        
        message.addAction(Action)
        
        
        return message
    }
    
    
    
    
    
}
