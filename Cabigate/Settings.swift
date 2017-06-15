//
//  Settings.swift
//  Cabigate
//
//  Created by abdur rehman on 6/7/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class Settings: UIViewController , UITextFieldDelegate  {

     let autocompleteController = GMSAutocompleteViewController()
    @IBOutlet weak var editButton: UIImageView!
    
    @IBOutlet weak var ChangePassword: UILabel!

    @IBOutlet weak var BackImg: UIImageView!
    @IBOutlet weak var BackImgView: UIView!
    @IBOutlet weak var BackButton: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var UserlastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var pNumber: UITextField!
    
    
    @IBOutlet weak var code: UITextField!
    
    @IBOutlet weak var addHome: UILabel!
    
    
    @IBOutlet weak var addWork: UILabel!
    
    @IBOutlet weak var updateinfoText: UILabel!
    var editCheak = false
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    // below view
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.set("dhaunkal12", forKey: "password")
     
        autocompleteController.delegate = self
       
        BackImgView.layer.cornerRadius = BackImgView.frame.width / 2
        BackImgView.clipsToBounds = true
        BackImg.layer.cornerRadius = BackImg.frame.width / 2
        BackImg.clipsToBounds = true
        
        userName.delegate = self
        email.delegate = self
        pNumber.delegate = self
        code.delegate = self
        UserlastName.delegate = self
        updateinfoText.isHidden = true
        visualEffect.isHidden = true
        activityIndecator.isHidden = true
       
        fetchUserDetailFunction()
        importantFetchFunction()
        let editTap = UITapGestureRecognizer(target: self, action: #selector(editFunction))
        
        editButton.addGestureRecognizer(editTap)
        editButton.isUserInteractionEnabled = true
        
        
        let changePassword = UITapGestureRecognizer(target: self, action: #selector(changepasswordNow))
        
        ChangePassword.addGestureRecognizer(changePassword)
        ChangePassword.isUserInteractionEnabled = true
      
        
        let FindWrokorHomeTap = UITapGestureRecognizer(target: self, action: #selector(FindHome))
        
        addHome.addGestureRecognizer(FindWrokorHomeTap)
        addHome.isUserInteractionEnabled = true
        
        let addWorkTap = UITapGestureRecognizer(target: self, action: #selector(FindWrok))
        
        addWork.addGestureRecognizer(addWorkTap)
        addWork.isUserInteractionEnabled = true
        
        let kk = UITapGestureRecognizer(target: self, action: #selector(goBackToGallery))
        
        BackButton.addGestureRecognizer(kk)
        BackButton.isUserInteractionEnabled = true
  
        
    }
    func goBackToGallery(){
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(withIdentifier: "Map")
        present(controller, animated: true, completion: nil)
    }
    
    func changepasswordNow(){
      
        
        let ale = UIAlertController(title:"Verification" , message: "Please Enter old password!", preferredStyle: UIAlertControllerStyle.alert)
        
        
        
        ale.addTextField { (textField) in
            
        }
        
        let CancleButton = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
            
        }
        ale.addAction(CancleButton)
        let Ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) in
            let Field = ale.textFields![0]
            
            
            let result = UserDefaults.standard.value(forKey: "password")
            
            if(Field.text == result as? String){
                
                self.verifyNowChangePass()
        
                
            }else{
                
                print("Not match")
            }

            
            
        }
        ale.addAction(Ok)
                self.present(ale, animated: true, completion: nil)
    
        
    }
    
    
    
    func verifyNowChangePass(){
        
        
        let ale = UIAlertController(title:"Please Provide New Password" , message: "Make sure password should match", preferredStyle: UIAlertControllerStyle.alert)
        
        
        
        ale.addTextField { (textField) in
            
        }
        ale.addTextField { (textfieldtwo) in
            
        }
        
        let CancleButton = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
            
        }
        ale.addAction(CancleButton)
        
        
        let Ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) in
            
            let Fieldone = ale.textFields![0]
    
            let Fieldtwo = ale.textFields![0]
            
            
        
            
            if(Fieldone.text == Fieldtwo.text){
                
                
                fetchUserDetail.object.UpdateUserDetail(Uname: self.userName.text!, Pass: Fieldone.text! ) { (msg) in
                    
                    if(msg == ""){
                        
                        UserDefaults.standard.set("\(Fieldone.text!)", forKey: "password")
                        self.fetchUserDetailFunction()
                        
                    }else{
                        
                        
                        
                        
                    }
                    
                    
                }
            }else{
                
                print("Not match")
            }
            
            
            
        }
        ale.addAction(Ok)
        self.present(ale, animated: true, completion: nil)
        
    }
    
    func fetchUserDetailFunction(){
        fetchUserDetail.object.downloadUserDetail { (results) in
            
            if(results == ""){
                
                
                self.userName.text = userDetail.object.fname
                self.email.text = userDetail.object.email
                self.pNumber.text = userDetail.object.phone
                self.UserlastName.text = userDetail.object.fname
                self.code.text = "\(self.flag(country:"GB"))+44"
                self.code.allowsEditingTextAttributes = false
                self.pNumber.allowsEditingTextAttributes = false
            
            }
            
            
            print(results)
            
        }

    }
    
    
    func importantFetchFunction(){
        
        
        let result = UserDefaults.standard.value(forKey: "WORK")
        
        
        if let PName = result as? NSDictionary{
            
            addWork.text = PName["PName"] as? String
            
        }
        let home = UserDefaults.standard.value(forKey: "HOME")
        
        if let PName = home as? NSDictionary{
            
            addHome.text = PName["PName"] as? String
            
        }
        
        
    }

    
    
    func editFunction(){
        
        if(editCheak == false){
            
      editButton.image = UIImage(named: "Menue")
      editCheak = true
           
        }
        
       else if(editCheak == true){
            
            
            if (self.userName.text == userDetail.object.fname){
                
              // do nothing value same he ha
            }else if (self.userName.text == "" || self.UserlastName.text == "" ){
                
                let controller =   alert.object.alertForSignin(title: "Missing UserName", message: "Please make sure you have put Some user Name")
                
                self.present(controller, animated: true, completion: nil)
                
              
            }
            else{
                
                updateinfoText.isHidden = false
                visualEffect.isHidden = false
                activityIndecator.isHidden = false
                activityIndecator.startAnimating()
                activityIndecator.color = UIColor.white
                performUpdateFunction()
              
                
            }
            
     editButton.image = UIImage(named: "edit")
     editCheak = false
            
        }
        
    }
    
    
    
    func performUpdateFunction(){
        
         let result = UserDefaults.standard.value(forKey: "password")
  fetchUserDetail.object.UpdateUserDetail(Uname: self.userName.text!, Pass: result as! String) { (msg) in
    
    if(msg == ""){
        
        self.activityIndecator.stopAnimating()
        self.updateinfoText.isHidden = true
        self.visualEffect.isHidden = true
        self.activityIndecator.isHidden = true
        self.fetchUserDetailFunction()
        
    }else{
    
    
  
     
    }
    
    
        }
        
    }
    
    
    
    
    func flag(country:String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in country.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }

    
  
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == userName){
            userName.text = ""
            
            

        }else if (textField == UserlastName){
            UserlastName.text = ""
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    var HomeOrWork:String = ""
    //false work 
    //true home
}



    extension Settings :GMSAutocompleteViewControllerDelegate  {
        
        

        func FindWrok(){
            
            HomeOrWork = "WORK"
             present(autocompleteController, animated: true, completion: nil)
        }
        func FindHome(){
               HomeOrWork = "HOME"
            present(autocompleteController, animated: true, completion: nil)
        }

        public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error){
            
        }
        public func wasCancelled(_ viewController: GMSAutocompleteViewController){
            
            dismiss(animated: true, completion: nil)
        }
      

        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            
            if (HomeOrWork == "HOME"){
                
                let dict:[String:String] = ["PName":"\(place.name)" , "PLog":"\(place.coordinate.longitude)" ,"PLat":"\(place.coordinate.latitude)"]
                
                UserDefaults.standard.set(dict, forKey: "HOME")
                let result = UserDefaults.standard.value(forKey: "HOME")
          
                if let PName = result as? NSDictionary{
                    
                   addHome.text = PName["PName"] as? String
                    
                }
                HomeOrWork = ""
                
            }else if (HomeOrWork == "WORK"){
                
                let dict:[String:String] = ["PName":"\(place.name)" , "PLog":"\(place.coordinate.longitude)" ,"PLat":"\(place.coordinate.latitude)"]
                
                UserDefaults.standard.set(dict, forKey: "WORK")
                let result = UserDefaults.standard.value(forKey: "WORK")
              
                
                if let PName = result as? NSDictionary{
                    
                    addWork.text = PName["PName"] as? String
                    
                }
                HomeOrWork = ""
            }
         
            
            dismiss(animated: true, completion: nil)
            
            
        }
        

    
}
