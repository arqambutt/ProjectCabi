//
//  viewHeloper.swift
//  Cabigate
//
//  Created by abdur rehman on 7/21/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation
class viewHelper {
    
    
    static var instance = viewHelper()

    
    func view_circle(views:UIView){
        views.layer.cornerRadius = views.frame.size.width/2
        views.clipsToBounds = true
    }
    
    func bottom_Line(views:UIView) {
        
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = UIColor(red:6/255.0, green:191/255.0, blue:195/255.0, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: views.frame.size.height - width, width:  views.frame.size.width, height: views.frame.size.height)
        border.borderWidth = width
        views.layer.addSublayer(border)
        views.layer.masksToBounds = true
        
    }
    
    
    
    
    func border_Function(views: UIView, colorName: String){
        
        switch colorName {
        case "white":
            views.layer.borderWidth = 1
            views.layer.borderColor = UIColor(red:255/255.0, green:255/255.0, blue:255/255.0, alpha: 1.0).cgColor
            break
        case "blue":
            views.layer.borderWidth = 1
            views.layer.borderColor = UIColor(red:6/255.0, green:191/255.0, blue:195/255.0, alpha: 1.0).cgColor
            break
        default:
            print("Nothing")
        }
        
    }
    
}
