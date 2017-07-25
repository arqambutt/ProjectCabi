//
//  PromotionCell.swift
//  Cabigate
//
//  Created by abdur rehman on 7/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class PromotionCell: UICollectionViewCell {
    
    @IBOutlet weak var code: UILabel!
  
    @IBOutlet weak var desText: UILabel!
    @IBOutlet weak var expiry: UILabel!
    
    func configration(object:promo) {
        
        
        code.text = object.code
        desText.text = object.description
        expiry.text = object.expiry
        
        
    }
    
}
