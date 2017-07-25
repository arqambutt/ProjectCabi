//
//  CollectionViewCell.swift
//  Cabigate
//
//  Created by abdur rehman on 7/12/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
  
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var taxiName: UILabel!
   
 
  
    
    func configrationOfCell(name:String , ImgURL:String){
        
        
        Image.sd_setImage(with: URL(string: ImgURL), placeholderImage:UIImage(named: "back"), options: [.continueInBackground, .progressiveDownload])
        
        taxiName.text = name
        
    }
    


    
    
    
}
