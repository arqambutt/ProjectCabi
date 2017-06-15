//
//  HistoryCell.swift
//  Cabigate
//
//  Created by abdur rehman on 6/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import GoogleMaps


class HistoryCell: UICollectionViewCell {
 
    
    
    @IBOutlet weak var a: GMSMapView!
    
    @IBOutlet weak var imgback: UIView!
    @IBOutlet weak var Time: UILabel!
   
    @IBOutlet weak var imgFront: UIImageView!
    
    @IBOutlet weak var Pounds: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        imgback.layer.cornerRadius = imgback.frame.width / 2
        imgback.clipsToBounds = true
        imgback.backgroundColor = UIColor.white
        
        imgFront.layer.cornerRadius = imgFront.frame.width / 2
        imgFront.clipsToBounds = true
        imgFront.image = UIImage(named: "driver")
    }
    
    
    
    func configurationofCell(object:historyclass){
    
        
        a.clear()
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: Double(object.pickup_lat!)!, longitude: Double(object.pickup_lng!)!))
        path.add(CLLocationCoordinate2D(latitude: Double(object.drop_lat!)!, longitude: Double(object.drop_lng!)!))
    
        
        let rectangle = GMSPolyline(path: path)
        rectangle.strokeColor = .gray
        rectangle.strokeWidth = 4
        rectangle.geodesic = true
        rectangle.map = a
        
        
        let pick = CLLocationCoordinate2D(latitude: Double(object.pickup_lat!)!, longitude:  Double(object.pickup_lng!)!)
        let picmarker = GMSMarker(position: pick)
        picmarker.icon = scaleImageToSize(img: UIImage(named: "green")! , size: CGSize(width: 20, height: 20
        ))
        picmarker.title = "\(object.pickup_location!)"
        picmarker.map = a
        
        let drop = CLLocationCoordinate2D(latitude: Double(object.drop_lat!)!, longitude:  Double(object.drop_lng!)!)
        let dropmarker = GMSMarker(position: drop)
          dropmarker.icon = scaleImageToSize(img: UIImage(named: "red")! , size: CGSize(width: 20, height: 20))
         
        dropmarker.title = "\(object.drop_location!)"
        dropmarker.map = a
        

        let bounds = GMSCoordinateBounds(path: path)
     
            let update = GMSCameraUpdate.fit(bounds, withPadding: 80)
        a.animate(with: update)
        
     
        
        Pounds.text = object.total_fare
      
        
        if(object.pickup_datetime != nil){
            
            let date = convertDateFormatter(date: object.pickup_datetime!)
            
            Time.text = date
            
        }
     
        
    
    
    
    }
    
    
    func convertDateFormatter(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"//this your string date format
       
    
        var y :NSDate?
        if let date = dateFormatter.date(from: date){
            
            y = date as NSDate
           
        }
        
         //let Sdate = dateFormatter.string(from: y as Date)
            
        
        
        
    
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        
        var finalString:String = ""
        
        if let datee = dateFormatter.string(for: y){
            
            finalString = datee
            
        }
            

        return finalString
        
    
    }
    
  
    func scaleImageToSize(img: UIImage, size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        img.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
        
        
        
    }
    
    
    
}
