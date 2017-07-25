
//
//  Created by abdur rehman on 6/1/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit


class Signin: UIViewController , UITextFieldDelegate {

    static var instance  = Signin()
    static var object :Signin {
        return instance
    }
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var car: UIImageView!
    @IBOutlet weak var forGetPass: UILabel!
    @IBOutlet weak var passField: UITextField!
    var bounce = false


    @IBAction func login(_ sender: Any) {
    
        signinController.object.signIn(companiId: defaultSettings.object.companyId, email: emailField.text!, password: passField.text!, method: defaultSettings.object.method) { (results) in
            
            if (results == ""){
                
                
                UserDefaults.standard.set(self.passField.text!, forKey: "password")
               let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let Controller = storyBoard.instantiateViewController(withIdentifier: "Map")
                self.present(Controller, animated: true, completion: nil)

                
            }else {
                
                
                let alertController = alert.object.alertForSignin(title: "Authantication Error " , message: results)
                
                self.present(alertController, animated: true, completion: nil)
                
            }
            
            
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    
        car.frame.origin.x -= 215
        self.logoView.alpha = 0
        emailField.delegate = self
        passField.delegate = self
        
        logoView.layer.cornerRadius = logoView.frame.size.width/2
        logoView.clipsToBounds = true
        
        self.logoView.layer.borderWidth = 3
        self.logoView.layer.borderColor = UIColor(red:255/255.0, green:255/255.0, blue:255/255.0, alpha: 0.8).cgColor
        
        
        
        forGetPass.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(clicked))
        forGetPass.addGestureRecognizer(tap)
        
        
        self.view.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tap1)
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animateKeyframes(withDuration: 2.2, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 0.2, animations: {
                
                UIView.animate(withDuration: 1.9, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [.curveEaseOut], animations: {
                    self.car.frame.origin.x += 215
                    
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.5, animations: {
                    self.logoView.alpha = 1
                       
                    })
                })
                
                
            })
            
      
        }, completion: nil)
    }

    
    func closeKeyboard(){
        
          if(bounce == true){
        UIView.animate(withDuration: 0.1, animations: {
          
  
            self.view.frame.origin.y += 100
        })
          bounce = false
        }
        view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == emailField) {
            print("text filed")
            if(bounce == false){
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame.origin.y -= 100
            })
             bounce = true
            }
        }else{
            print("No text field")
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
    
    func clicked() {
        print("Cicked")
    }
    
    
    
}
