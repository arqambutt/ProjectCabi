//
//  sideMenuCell.swift
//  Cabigate
//
//  Created by abdur rehman on 6/5/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class flipMenuCell: UICollectionViewCell {
    
    
    @IBOutlet weak var BackGroungView: UIView!
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var taxiName: UILabel!
    
    override var isSelected: Bool{
        
       
            didSet{
                print("Highlighted is set \(isSelected)")
                if(isSelected == true){
                    self.BackGroungView.backgroundColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1)
                    
                }else{
                    self.BackGroungView.backgroundColor = UIColor.clear
                }
            }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()

        BackGroungView.layer.cornerRadius = BackGroungView.frame.width / 2
        BackGroungView.clipsToBounds = true
    }
    

    
    
    

    
    func configrationOfCell(name:String , Img:UIImage){
        
    
        Image.image = Img
        taxiName.text = name
        
        
        
    }
    
    
    
}
