//
//  TableViewCell.swift
//  Cabigate
//
//  Created by abdur rehman on 7/12/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var settingPic: UIImageView!
    
    @IBOutlet weak var settingLabel: UILabel!
    
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        if(selected == true){
            
            selectedBackgroundView?.backgroundColor = UIColor.white
        }
        
        
        selectedBackgroundView?.backgroundColor = UIColor.clear
        
        
    }


}
