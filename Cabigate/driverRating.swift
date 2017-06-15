//
//  driverRating.swift
//  Cabigate
//
//  Created by abdur rehman on 6/10/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class driverRating: UIViewController {
    
    @IBOutlet weak var driverPiC: UIImageView!
    
    @IBOutlet weak var driverUserName: UILabel!
    
    @IBOutlet weak var secondarName: UILabel!
    
    @IBOutlet weak var Rating: UILabel!
    
    
    // dono py laga do same action
    @IBOutlet weak var cancleButtonACTION: UILabel!
    @IBOutlet weak var cancleImg: UIImageView!
    
    @IBOutlet weak var selectDriver: UILabel!
    
    @IBOutlet weak var selectDriverImg: UIImageView!
    
   
    @IBOutlet weak var firstStar: UIImageView!

    @IBOutlet weak var secondStar: UIImageView!
    
    @IBOutlet weak var thirdStar: UIImageView!
    
    @IBOutlet weak var forthStar: UIImageView!
    
    @IBOutlet weak var fifthStar: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        animations()
    }

    
    func starRatingFunction(Value:Int){
        
        
        
        switch Value {
            
        case 20:
            print("20 is a value")
            break
            
        case 40:
            print("40 is a value")
            break
            
        case 60:
            print("60 is a value")
            break
            
            
        case 80:
            print("80 is a value")
            break
            
        case 1000:
            print("100 is a value")
            break
            
        default:
            break
        }
        
        
        
    }
 
    func animations(){
        
        
        driverPiC.layer.cornerRadius = driverPiC.frame.width / 2
        driverPiC.clipsToBounds = true
        
        
        
        
        
        
    }
}
