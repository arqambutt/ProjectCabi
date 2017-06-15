//
//  VisaCellView.swift
//  Cabigate
//
//  Created by abdur rehman on 6/14/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class VisaCellView: UITableViewCell {
    
    
    @IBOutlet weak var expMonthLabel: UILabel!
    
    @IBOutlet weak var expMonth: UILabel!
    
    @IBOutlet weak var expYearLabel: UILabel!
    
    @IBOutlet weak var expYear: UILabel!
    
    @IBOutlet weak var LastFourDigitLabel: UILabel!
    
    @IBOutlet weak var defaultImg: UIImageView!
    
    @IBOutlet weak var Digit: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    defaultImg.isHidden = true
        
    }

    
    func Configuration(object:cardHistoryClass){
        
        expMonth.text = object.exp_month
        expYear.text = object.exp_year
        Digit.text = object.last4
        
        
        
     
        
        if(object.defaultt == "0"){
            
            defaultImg.isHidden = true
            
            
        }else{
            
            defaultImg.isHidden = false
            
        }
        
    
    
    }
    
    
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
