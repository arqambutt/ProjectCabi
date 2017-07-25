//
//  Addplaces.swift
//  Cabigate
//
//  Created by abdur rehman on 7/24/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import GooglePlaces


class Addplaces: UIViewController , UITextFieldDelegate  {

    @IBOutlet weak var addhome: UITextField!
    
    @IBOutlet weak var addWork: UITextField!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var HomeOrWork = ""
    var places:GMSPlace? = nil
    
    
    let autocompleteController = GMSAutocompleteViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        autocompleteController.delegate = self
        addhome.delegate = self
        addWork.delegate  = self
        
        
        activity.isHidden = true
      loadCoustom()
        
    }

    
    func loadCoustom (){
        
        
        if(userDetail.object.home_address != ""){
            
            addhome.text = "\(userDetail.object.home_address )"
        }
        
        if(userDetail.object.work_address != ""){
            
            addWork.text = "\(userDetail.object.work_address )"
        }
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == addhome){
            HomeOrWork = "HOME"
            present(autocompleteController, animated: true, completion: nil)
            
        }else if (textField == addWork){
            HomeOrWork = "WORK"
            present(autocompleteController, animated: true, completion: nil)
            
        }
        
    }
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBAction func Update(_ sender: Any) {
        
        
        self.activity.stopAnimating()
        self.activity.isHidden = true
        
        
        if(HomeOrWork == "HOME"){
         
            
    fetchUserDetail.object.UpdatehomeAddress(homeName: String(describing: places!.formattedAddress!), Lat:String((places?.coordinate.latitude)!) , lon: String((places!.coordinate.longitude)), results: { (resut) in
        
        self.activity.isHidden = false
        self.activity.startAnimating()
        self.updateButton.setTitle("UPDATING...", for: UIControlState.normal)
        
        if(resut == ""){
            
            fetchUserDetail.object.downloadUserDetail(results: { (res) in
                
                if(res == ""){
                    
                    self.loadCoustom()
                }
            })
             self.activity.stopAnimating()
            self.activity.isHidden = true
           
            self.updateButton.setTitle("DONE", for: UIControlState.normal)
        }
    })
        

            
        }else if (HomeOrWork == "WORK") {
            
          
            
            fetchUserDetail.object.UpdateWorkAddress(workName: String(describing: places!.formattedAddress!), Lat:String((places?.coordinate.latitude)!) , lon: String((places!.coordinate.longitude)), results: { (resut) in
                  self.updateButton.setTitle("UPDATING...", for: UIControlState.normal)
                self.activity.isHidden = false
                self.activity.startAnimating()
              
                
                if(resut == ""){
                    
                    
                    fetchUserDetail.object.downloadUserDetail(results: { (res) in
                        
                        if(res == ""){
                            
                            self.loadCoustom()
                        }
                    })
                    self.activity.stopAnimating()
                    self.activity.isHidden = true
                    
                    self.updateButton.setTitle("DONE", for: UIControlState.normal)
                    
                }
            })
            
        }
        
        
    }

}

var preferredStatusBarStyle: UIStatusBarStyle{
    
    return UIStatusBarStyle.lightContent
}

extension Addplaces :GMSAutocompleteViewControllerDelegate  {
    
    
  
    
    public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error){
        
    }
    public func wasCancelled(_ viewController: GMSAutocompleteViewController){
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        places = place
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
}
