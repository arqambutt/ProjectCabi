//
//  SemiQuestionView.swift
//  Cabigate
//
//  Created by abdur rehman on 7/16/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleMaps


class SemiQuestionView: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {


    @IBOutlet weak var piclocation: UILabel!
    @IBOutlet weak var dropLocation: UILabel!
    @IBOutlet weak var driverback: UIView!
    @IBOutlet weak var driverImg: UIImageView!
    @IBOutlet weak var dnname: UILabel!
    @IBOutlet weak var platNumber: UILabel!
    @IBOutlet weak var pounds: UILabel!
    @IBOutlet weak var Cv: UICollectionView!
    
    
    lazy var object:historyclass? = Send.object.object
    

    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("Memory warning remove")
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        object = nil
        Cv.removeFromSuperview()
     
    
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        viewHelper.instance.view_circle(views: driverback)
        viewHelper.instance.view_circle(views: driverImg)
       
        
        if let u  = object?.plate_number {
            
            platNumber.text = u
            
            
        }
        
        if let u  = object?.driver_name {
            
            dnname.text = u
            
            
        }
        
        if let u  = object?.total_fare {
            
            pounds.text = u
        }
        
        if let u  = object?.drop_location {
            
            
            dropLocation.text = u
            
        }
        
        
        
        if let u  = object?.driver_image {
            
            let imgurl:NSURL? = NSURL(string: "\(u)")!
            
            
            
            let manager:SDWebImageManager = SDWebImageManager.shared()
            manager.imageDownloader?.downloadImage(with: imgurl! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload , .useNSURLCache], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
                
                self.driverImg.image = IMG
                
                
            })
        }
        
        
        if let u  = object?.pickup_location {
            
            piclocation.text = u
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
     
        if(Ques.QuestionAnswe.count != 0){
            
             self.Cv.reloadData()
            
        }else {
            
            Ques.object.FetchQuest { (tell) in
                
                if(tell == true){
                    
                    self.Cv.reloadData()
                }else {
                    
                    print("Error")
                }
            }
        }
    
    }

    
    

    
    func scaleImageToSize(img: UIImage, size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        img.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as! historyCoustomCell
        
        cell.configurCell(Question:Ques.QuestionAnswe[indexPath.item].heading!)
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "FinalHistory") as! FinalViewHistory
     
      controller.obj = Ques.QuestionAnswe[indexPath.item]
        
        
        self.navigationController?.pushViewController(controller, animated: true)
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Ques.QuestionAnswe.count
    }
    
    
    
    
    

}


class historyCoustomCell :UICollectionViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    
    
    
    
    func configurCell(Question:String){
        
        label.text = Question
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}


