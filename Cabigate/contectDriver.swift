//
//  contectDriver.swift
//  Cabigate
//
//  Created by abdur rehman on 7/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import MessageUI

class contectDriver: UIViewController , MFMessageComposeViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

       self.view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.view.addGestureRecognizer(tap)

       
        
    }

    
    func dismissView(){
        
       
        dismiss(animated: true, completion: nil)
    }


    @IBAction func callDriver(_ sender: Any) {
        
        
     
            
            let phoneNumber:String = "tel:" + (nearestDriverController.DriverCsTATUS?.driver_contact)!
        
            UIApplication.shared.open((URL(string: phoneNumber)!), options: [:], completionHandler: nil)
        
        
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func MessageSending(_ sender: Any) {
        
        
      
            
            if (MFMessageComposeViewController.canSendText()){
                let controller = MFMessageComposeViewController()
                controller.body = "Hellow Where are you!"
                controller.recipients = [(nearestDriverController.DriverCsTATUS?.driver_contact)!]
                controller.messageComposeDelegate = self
                self.present(controller, animated: true, completion: nil)
            }
            

        
        
   }
    
    
}
