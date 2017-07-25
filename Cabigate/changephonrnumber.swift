//
//  changephonrnumber.swift
//  Cabigate
//
//  Created by abdur rehman on 7/24/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class changephonrnumber: UIViewController {

    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var mobileView: UIView!
    
    @IBOutlet weak var code: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewHelper.instance.bottom_Line(views: mobileView)
    }

   
    
    @IBAction func verifyPhone(_ sender: Any) {
        
        if(phone.text! != "" && code.text! != ""){
            
            let number = "\(code.text!)\( phone.text!)"
           
            
            changePhoneNumber.object.verifyPhoneNumber(phonenumber: number , result: { (result) in
                
                if(result == ""){
                    
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "Verify") as! VerifyePhoneNumber
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                   
                    
                }else{
                    
                    
                    let u = alert.object.alertForSignin(title: "Sorry ;(", message: "Phone number is not valid")
                    
                    self.present(u, animated: true, completion: nil)
                }
                
            })
         
            
        }else {
            
            let message = UIAlertController(title:"oops" , message: "Make sure you have entered phone number and Country code", preferredStyle: UIAlertControllerStyle.alert)
            
            let Action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive) { (UIAlertAction) in
                
            }
            
            
            message.addAction(Action)
            
            self.present(message, animated: true, completion: nil)
            
        }
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return UIStatusBarStyle.lightContent
    }

}
