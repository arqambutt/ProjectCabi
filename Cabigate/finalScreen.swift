//
//  finalScreen.swift
//  Cabigate
//
//  Created by abdur rehman on 7/11/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import SDWebImage

class finalScreen: UIViewController ,FloatRatingViewDelegate {

    @IBOutlet weak var dreiverImg: UIImageView!
    @IBOutlet weak var driverName: UILabel!
    
    @IBOutlet weak var starView: FloatRatingView!
    
    @IBOutlet weak var trophyView: UIView!
    
    
    @IBOutlet weak var feedBackText: UITextField!
    
    
    @IBOutlet weak var imgbackView: UIView!
    
    @IBAction func Submit(_ sender: Any) {
        
        
        let storyBord = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBord.instantiateViewController(withIdentifier: "Map")
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    
    
    func SetValues() {
        
        let imgurll:NSURL? = NSURL(string: "\(String(describing: nearestDriverController.DriverCsTATUS!.driver_image))")!
        
        
        
        let managerr:SDWebImageManager = SDWebImageManager.shared()
        managerr.imageDownloader?.downloadImage(with: imgurll! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload , .useNSURLCache], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
            
            self.dreiverImg.image = IMG
            
        })
        
        
        driverName.text = nearestDriverController.DriverCsTATUS!.driver_name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetValues()
        
        trophyView.layer.cornerRadius = trophyView.frame.size.width/2
        trophyView.clipsToBounds = true
        
        dreiverImg.layer.cornerRadius = dreiverImg.frame.size.width/2
        dreiverImg.clipsToBounds = true
        
        imgbackView.layer.cornerRadius = imgbackView.frame.size.width/2
        imgbackView.clipsToBounds = true
        
        self.trophyView.layer.borderWidth = 6
        self.trophyView.layer.borderColor = UIColor(red:230/255.0, green:230/255.0, blue:230/255.0, alpha: 0.5).cgColor
        
        
        self.starView.delegate = self
        self.starView.contentMode = UIViewContentMode.scaleAspectFit
        self.starView.maxRating = 5
        self.starView.minRating = 0
        self.starView.editable = true
        //self.ratingView.halfRatings = true
        //self.ratingView.floatRatings = false
    }

    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        print(ratingView.rating)
        
    }
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Float) {
        print(ratingView.rating)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      
        return UIStatusBarStyle.lightContent
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.resignFirstResponder()
        return true
    }
    

}
