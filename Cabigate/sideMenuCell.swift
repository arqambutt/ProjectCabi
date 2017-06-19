//
//  sideMenuCell.swift
//  Cabigate
//
//  Created by abdur rehman on 6/5/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import SDWebImage

class flipMenuCell: UICollectionViewCell {
    
    
    @IBOutlet weak var BackGroungView: UIView!
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var taxiName: UILabel!
    
    var url = ""
    var imgg = UIImage()
    
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
    

    
    
    

    
    func configrationOfCell(name:String , ImgURL:String){
        

        Image.sd_setImage(with: URL(string: ImgURL), placeholderImage:UIImage(named: "back"), options: [.continueInBackground, .progressiveDownload])
       // Image.image = Img
        taxiName.text = name
       
    }
   
//        
//        if (url == ""){
//            
//            
//             let imgurl:NSURL? = NSURL(string: "\(ImgURL)")!
//            
//            url = ImgURL
//            
//            
//            let manager:SDWebImageManager = SDWebImageManager.shared()
//            manager.imageDownloader?.downloadImage(with: imgurl! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
//                
//                
//               self.Image.image = IMG
//                self.imgg = IMG!
//                
//            })
//            
//            
//        }else if(url == ImgURL){
//            
//            
//          self.Image.image = imgg
//            
//            
//            
//        }else if (url != ImgURL) {
//            
//            let imgurl:NSURL? = NSURL(string: "\(ImgURL)")!
//            
//            url = ImgURL
//            
//            
//            let manager:SDWebImageManager = SDWebImageManager.shared()
//            manager.imageDownloader?.downloadImage(with: imgurl! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
//                
//                
//                self.Image.image = IMG
//                self.imgg = IMG!
//                
//                
//                
//            })
//            
//            
//            
//        }
//        
//
//        
//        
//    }
//    
    
    
}
