//
//  FinalViewHistory.swift
//  Cabigate
//
//  Created by abdur rehman on 7/16/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class FinalViewHistory: UIViewController {

    
    lazy var obj:qAModal? = nil
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("Memory warning remove")
    }
    
    @IBAction func backBUTTON(_ sender: Any) {
        
        obj = nil
        
        
    }
    
    @IBOutlet weak var DetalDes: UITextView!
    
    @IBOutlet weak var TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DetalDes.text =   obj?.details!
        
        
        
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

    @IBAction func subMitMessage(_ sender: Any) {
        
        
        Complainclass.object.FetchHistory(jobId: (Send.object.object?.job_id!)!, needHelp: (obj?.ID!)!, Comment:TextField.text!) { (result) in
            
            if(result == true){
                
            
                self.DetalDes.text = "We have receive you Complain and we will respond you as soon as possible!"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    
                    
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "Map")
                    
                    self.present(controller, animated: true, completion: nil)
                    
                }
            }else {
                
                
                print("You have chuss")
            }
            
            
        }
        
        
    }
   

}
