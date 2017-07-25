//
//  VerifyePhoneNumber.swift
//  Cabigate
//
//  Created by abdur rehman on 6/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class VerifyePhoneNumber: UIViewController {
    
    
    @IBOutlet weak var VerificationNumber: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }

 
    @IBAction func clickVerify(_ sender: Any) {
        
   verification()
        
    }
    
    
  
    func verification(){
        
  
        
        VerifyMyNumber.object.PerformVerification(Code: VerificationNumber.text!) { (result) in
            
            
            if(result == ""){
                
                    
                    let storyboad = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboad.instantiateViewController(withIdentifier: "Map")
                    self.present(controller, animated: true, completion: nil)
                    

            }else{
                
                let jj = alert.object.alertForSignin(title: "VerificationError", message: result)
                
                self.present(jj, animated: true, completion: nil)
            }
            
            
        }
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.resignFirstResponder()
        return true
    }
    
    
}
