//
//  HistoryDetail.swift
//  Cabigate
//
//  Created by abdur rehman on 7/16/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import SDWebImage

class HistoryDetail: UIViewController, FloatRatingViewDelegate {
   
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        
        
    }


    @IBOutlet weak var picLocation: UILabel!
    @IBOutlet weak var dropLocation: UILabel!
    @IBOutlet weak var rideDate: UILabel!
    @IBOutlet weak var pounds: UILabel!
    @IBOutlet weak var paymentStatus: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var driverSubName: UILabel!
    @IBOutlet weak var driverPhoneNumber: UILabel!
    @IBOutlet weak var dimgBackView: UIView!
    @IBOutlet weak var driverImg: UIImageView!
    @IBOutlet weak var dRating: FloatRatingView!
    @IBOutlet weak var cBackView: UIView!
    @IBOutlet weak var cImg: UIImageView!
    @IBOutlet weak var cName: UILabel!
    @IBOutlet weak var Cplate: UILabel!
    @IBOutlet weak var Tdistance: UILabel!
    @IBOutlet weak var nOfPessanger: UILabel!
    @IBOutlet weak var TotalTime: UILabel!
    @IBOutlet weak var needHelp: UIButton!
    
    var object:historyclass? = Send.object.object
    
    @IBOutlet weak var rideAgainInstance: UIButton!
    
    @IBAction func RoideAgain(_ sender: Any) {
        
          booking.object.currentlocName = object!.pickup_location!
          booking.object.DeslocName = object!.drop_location!
          booking.object.picUpLat = object!.pickup_lat!
          booking.object.picUpLon = object!.pickup_lng!
          booking.object.dropUpLat = object!.drop_lat!
          booking.object.dropUpLon = object!.drop_lng!
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let Controller = storyBoard.instantiateViewController(withIdentifier: "Map")
        self.present(Controller, animated: true, completion: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        
        object = nil
        picLocation = nil
        dropLocation = nil
        rideDate = nil
        
        
    }
    
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DefaultSettings()
    }
    
 
    
    func DefaultSettings(){
    
    self.dRating.delegate = self
    self.dRating.contentMode = UIViewContentMode.scaleAspectFit
    self.dRating.maxRating = 5
    self.dRating.minRating = 0
    self.dRating.editable = false
    self.dRating.floatRatings = false
    
        rideAgainInstance.layer.borderWidth.add(1)
        rideAgainInstance.layer.cornerRadius = needHelp.frame.width / 10
        rideAgainInstance.layer.borderColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1).cgColor
    
    
    needHelp.layer.borderWidth.add(1)
    needHelp.layer.cornerRadius = needHelp.frame.width / 10
    needHelp.layer.borderColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1).cgColor
    
        viewHelper.instance.view_circle(views:dimgBackView )
        viewHelper.instance.view_circle(views:driverImg )
        viewHelper.instance.view_circle(views:cBackView )
        viewHelper.instance.view_circle(views:cImg )
        
    
    

    if let u  = object?.distance {
    
    Tdistance.text = u
    }
    
    if let u  = object?.driver_image {
    let imgurl:NSURL? = NSURL(string: "\(u)")!
    
    
    
    let manager:SDWebImageManager = SDWebImageManager.shared()
    manager.imageDownloader?.downloadImage(with: imgurl! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload , .useNSURLCache], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
    
    self.driverImg.image = IMG
    
    
    })
    }
    if let u  = object?.driver_phone {
    
    driverPhoneNumber.text = "(+44) \(u)"
    
    }
        
        if let u  = object?.driver_rating {
            
              dRating.rating = Float(u)!
            
        }
        
    
    
    if let u  = object?.pickup_datetime {
    
    rideDate.text = u
    
    }
 
    if let u  = object?.drop_location {
    
    dropLocation.text = u
    
    }
    
    if let u  = object?.duration {
    
    TotalTime.text = u
    
    }
    
    if let u  = object?.driver_name {
    
    driverName.text = u
    driverSubName.text = u
    
    }
    
    
    if let u  = object?.passengers {
    
    nOfPessanger.text = u
    
    }
    
    if let u  = object?.payment_method {
    
    paymentStatus.text = u
    }
    
 
    
    if let u  = object?.pickup_location{
    
    picLocation.text = u
    }
    
    if let u  = object?.plate_number {
    
    Cplate.text = u
    }
    
    
    if let u  = object?.total_fare {
    
    pounds.text = u
    }
    
    if let u  = object?.vehicle_image {
    
    let imgurl:NSURL? = NSURL(string: "\(u)")!
    
    
    
    let manager:SDWebImageManager = SDWebImageManager.shared()
    manager.imageDownloader?.downloadImage(with: imgurl! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload , .useNSURLCache], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
    
    self.cImg.image = IMG
    
    
    })
    }
    
    
    if let u  = object?.status {
    
    status.text = u
    }
    

    
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("Memory warning remove")
    }


}
