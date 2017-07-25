//
//  promotionController.swift
//  Cabigate
//
//  Created by abdur rehman on 7/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation

class promotionController:UIViewController {
    
    
    @IBOutlet weak var GENERAGEcODE: UILabel!
    @IBOutlet weak var conversationBackView: UIView!
    @IBOutlet weak var codeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversationBackView.layer.cornerRadius = conversationBackView.frame.size.width/2
        conversationBackView.clipsToBounds = true
        
        self.codeView.layer.borderWidth = 1
        self.codeView.layer.borderColor = UIColor(red:255/255.0, green:255/255.0, blue:255/255.0, alpha: 1.0).cgColor
        
        
        
        FreeRideClass.object.FreeRideFun { (result) in
            
            if(result == ""){
                
                self.setValues()
                
            }else {
                
                
                
            }
            
            
            
        }
    }
    
    
    func setValues() {
        
         let str = FreeRideClass.RideDetail!.invitaion_link
        
        let startIndex = str.index(str.startIndex, offsetBy: 41)
        let endIndex = str.index(str.startIndex, offsetBy: str.characters.count - 1)
        
        if(str[startIndex...endIndex].characters.count > 1){
            
            
            GENERAGEcODE.text = "\(str[startIndex...endIndex])"
        }
      
       
  
    }
    
    @IBAction func sENDiNVITATION(_ sender: Any) {
        
        if(FreeRideClass.RideDetail!.invitaion_link != ""){
            
            let activity = UIActivityViewController(activityItems: ["\(FreeRideClass.RideDetail!.invitaion_link) \(String(describing: FreeRideClass.RideDetail!.invitaion_message))"], applicationActivities: nil)
            
            self.present(activity, animated: true, completion: nil)
            
        }
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        FreeRideClass.RideDetail = nil
        
    }
    
    
    
    
}
