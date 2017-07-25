//
//  myTableViewCell.swift
//  carcabigateFinal
//
//  Created by Arqam Butt on 22/07/2017.
//  Copyright © 2017 Arqam Butt. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
   
    
    
    @IBOutlet weak var fnameLabel: UILabel!
       @IBOutlet weak var fullNameLabel: UILabel!

    @IBOutlet weak var displayImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
