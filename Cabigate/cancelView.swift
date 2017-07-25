//
//  cancelView.swift
//  Cabigate
//
//  Created by abdur rehman on 7/20/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class cancelView: UIViewController {

    @IBOutlet weak var cancelbuttonView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        cancelbuttonView.layer.borderWidth = 1
        cancelbuttonView.layer.borderColor = UIColor(displayP3Red: 6/255, green: 191/255, blue: 195/255, alpha: 1).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancel(_ sender: Any) {
   
      dismiss(animated: true, completion: nil)
    
    }
    
    @IBOutlet weak var text: UITextField!
    
    @IBAction func conferm(_ sender: Any) {
        
       
        let result = UserDefaults.standard.value(forKey: "State")
        
        if let temp = result as? NSDictionary{
            
            let u = (temp["jobid"] as? String)!

            if (u != ""){
                
                CacnelBooking.object.cancelapi(jobId: u,  Resion: "\(String(describing: text.text!))") { (result) in
                    
                    if(result == true){
                        
                        let u = waitingScreen()
                        u.SetValuetoShare(type: "remove")
                        let storyBord = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyBord.instantiateViewController(withIdentifier: "Map")
                        self.present(controller, animated: true, completion: nil)
                        
                    }else {
                        
                    }
                }
            }
        }
    }
    

}
