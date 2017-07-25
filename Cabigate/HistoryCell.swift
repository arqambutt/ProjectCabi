//
//  HistoryCell.swift
//  Cabigate
//
//  Created by abdur rehman on 6/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import SDWebImage


class HistoryCell: UICollectionViewCell {
 
    
    
   
    @IBOutlet weak var mapImg: UIImageView!
    @IBOutlet weak var imgback: UIView!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var smallView: UIView!
    @IBOutlet weak var imgFront: UIImageView!
    @IBOutlet weak var DriverName: UILabel!
    @IBOutlet weak var CarName: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var fare: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
          viewHelper.instance.view_circle(views: imgFront)
          viewHelper.instance.view_circle(views: imgback)
          viewHelper.instance.view_circle(views: smallView)
       
    }
    
   
    
    func configurationofCell(object:historyclass){
    

        
        
        
        let M1 = "\(object.pickup_lat!),\(object.pickup_lng!)"
        let M2 = "\(object.drop_lat!),\(object.drop_lng!)"
        let staticMapUrl: String = "https://maps.googleapis.com/maps/api/staticmap?&zoom=12&size=400x400&scale=2&markers=size:large|color:red|label:S|\(M1)&markers=size:large|color:red|label:D|\(M2)&path=weight:3|color:red|enc:polyline_data&size=400x400&style=feature:road&path=color:blue|weight:5|\(M1)|\(M2)&key=AIzaSyDgf0Gt6LSKWCDGkZCMe-50Xi3eK0tHtro"
        
        let url = URL(string: staticMapUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            mapImg.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground, .progressiveDownload])
        
        
        
        
        
        fare.text = "\(object.total_fare!)"
        Time.text = "\(object.pickup_datetime!)"
        DriverName.text = "\(object.Username!)"
        CarName.text = "\(object.taxi_model!)"
        rating.text = "\(object.driver_rating!)"
        carModel.text = "\(object.plate_number!)"
        
        imgFront.sd_setImage(with: URL(string:object.driver_image! ), placeholderImage: nil, options: [.continueInBackground, .progressiveDownload])
    }
    

  
    func scaleImageToSize(img: UIImage, size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        img.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
        
        
        
    }
    

}
