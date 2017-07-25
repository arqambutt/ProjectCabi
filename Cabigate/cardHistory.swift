//
//  cardHistory.swift
//  Cabigate
//
//  Created by abdur rehman on 6/14/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation


class cardHistoryClass{


   var cardid = ""
    var brand = ""
    var last4 = ""
    var exp_month = ""
    var exp_year = ""
    var defaultt = ""
   
    init(data:NSDictionary) {
        
        let Cs = data["cardid"] as! NSObject
        cardid = String(describing: Cs)
        
        let Css = data["brand"] as! NSObject
        brand = String(describing: Css)
        
        
        let Csa = data["last4"] as! NSObject
        last4 = String(describing: Csa)
        
        let Csr = data["exp_month"] as! NSObject
        exp_month = String(describing: Csr)
        
        let Csrf = data["exp_year"] as! NSObject
        exp_year = String(describing: Csrf)
        
        let def = data["default"] as! NSObject
        defaultt = String(describing: def)
        

        
    }
    
    
    deinit {
        
        print("deinitialized")
    }

}
