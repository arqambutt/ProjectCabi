//
//  changeName.swift
//  Cabigate
//
//  Created by abdur rehman on 7/24/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class changeName: UIViewController {

    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
       activity.isHidden = true
        // Do any additional setup after loading the view.
    }

  
    @IBAction func update(_ sender: Any) {
        
        
        if(fname.text! != "" && lastName.text! != ""){
            
            
            let result = UserDefaults.standard.value(forKey: "password")
            
            
            if(result != nil){
                
                fetchUserDetail.object.UpdateUserDetail(Uname: self.fname.text!, Pass: result as! String, LName:lastName.text! ) { (msg) in
                    self.activity.isHidden = false
                    self.activity.startAnimating()
                    
                    if(msg == ""){
                        self.activity.stopAnimating()
                        self.activity.isHidden = true
                        fetchUserDetail.object.downloadUserDetail(results: { (result) in
                            
                            
                        })
                        
                    }else{
                        
                        
                    }
                    
                    
                }
            
        }
        }else{
        
        
        
        let message = UIAlertController(title:"oops" , message: "Make sure you have entered first name and last name", preferredStyle: UIAlertControllerStyle.alert)
        
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
