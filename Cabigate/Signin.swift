
//
//  Created by abdur rehman on 6/1/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit


class Signin: UIViewController , UITextFieldDelegate {

    
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passField: UITextField!

    @IBAction func login(_ sender: Any) {
    
        signinController.object.signIn(companiId: defaultSettings.object.companyId, email: emailField.text!, password: passField.text!, method: defaultSettings.object.method) { (results) in
            
            if (results == ""){
                
               let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let Controller = storyBoard.instantiateViewController(withIdentifier: "Map")
                self.present(Controller, animated: true, completion: nil)

                
            }else {
                
                
                let alertController = alert.object.alertForSignin(title: "Authantication Error " , message: results)
                
                self.present(alertController, animated: true, completion: nil)
                
            }
            
            
        }
        
    }

    
    @IBAction func signUp(_ sender: Any) {
     
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let Controller = storyBoard.instantiateViewController(withIdentifier: "signUp")
        self.present(Controller, animated: true, completion: nil)
        
    }
    
    
    func VerifyUUID(){
        let temp  = UserDefaults.standard.value(forKey: "token")!
        
        
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
