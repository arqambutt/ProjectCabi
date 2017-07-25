//
//  askPayment.swift
//  Cabigate
//
//  Created by abdur rehman on 7/13/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class askPayment: UIViewController {

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissme))
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
        
        
    }

    
    func dismissme(){
        
        self.dismiss(animated: true, completion: nil)
    }
    func show(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "waitingForResponce")
        
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBOutlet weak var cash: UIButton!

    @IBAction func cashAction(_ sender: Any) {
        
    booking.object.payment = "Cash"
        
        show()
    
    }
    @IBAction func Craditard(_ sender: Any) {
        // this has been converted to paypal bro
         booking.object.payment = "PayPal"
        show()
        
    }
    
    
    
    
}
