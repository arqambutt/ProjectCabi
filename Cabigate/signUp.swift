//
//  signUp.swift
//  Cabigate
//
//  Created by abdur rehman on 6/4/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit


class signUp: UIViewController, UITextFieldDelegate  {

    
    
    
    @IBOutlet weak var SV: UIScrollView!

   
    @IBOutlet weak var Uname: UITextField!
    
    @IBOutlet weak var uEmail: UITextField!
    
    @IBOutlet weak var countryCodeField: UITextField!
    
    @IBOutlet weak var UPhNo: UITextField!
    
    @IBOutlet weak var uPass: UITextField!
    
   
    
    class countryCode {
        
        var flag:String = ""
        var Code:String = ""
        
        init(flag:String , Code:String) {
            
            self.flag = flag
            self.Code = Code
            
        }
    }
    
    var code:String = "44"
    
    var CountrtCodeArray = [countryCode]()
    
    
    
    
    
    
    
    var selectedDay: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    UPhNo.delegate = self
       uPass.delegate = self
        uEmail.delegate = self
        Uname.delegate = self
        
        
     
        
        countryCodeField.text = "\(flag(country:"GB"))+44"
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
      
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        createDayPicker()
        createToolbar()
        FetchCountryCode()
        
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == UPhNo){
            
               SV.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
            
        }else if(textField == uPass){
            
            SV.setContentOffset(CGPoint(x: 0, y: 160), animated: true)
        }
    }
    
 
  
    
    func FetchCountryCode() {
        
        CountrtCodeArray.removeAll()
    
        let request = NSMutableURLRequest(url: NSURL(string: "http://country.io/phone.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            
            
            do {
                
                let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                
                
                print(temp as NSDictionary)
                
                for i in temp {
                 
                self.CountrtCodeArray.append(countryCode.init(flag: i.key, Code: String(describing: i.value)))
                }
                
                
                
                
            }catch {
                print(error)
            }
        
    
        })
    
        dataTask.resume()
    }
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        countryCodeField.inputAccessoryView = toolBar
    }

    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    
    
    func createDayPicker() {
        
        let dayPicker = UIPickerView()
        dayPicker.delegate = self as UIPickerViewDelegate
        
        countryCodeField.inputView = dayPicker
        
        dayPicker.backgroundColor = .black
    }
    
  

    @IBAction func next(_ sender: Any) {
        
        
    
        signUpController.object.signUP(name: Uname.text! as String, email: uEmail.text! as String, pNumber: "+\(code)\(UPhNo.text! as String)", pass: uPass.text! as String) { (results) in
            
            if(results == ""){
                
                let storyboad = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboad.instantiateViewController(withIdentifier: "Verify")
                self.present(controller, animated: true, completion: nil)
                
            }else {
                
      let u = alert.object.alertForSignin(title: "Verification Error", message: results)
                self.present(u, animated: true, completion: nil)
            }
        }
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.resignFirstResponder()
        return true
    }
    
    
    
    
}

extension signUp: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func flag(country:String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in country.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CountrtCodeArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedDay = CountrtCodeArray[row].Code
        let flagg = CountrtCodeArray[row].flag
        
        code = CountrtCodeArray[row].Code
        countryCodeField.text = "\(flag(country:flagg))+\(String(describing: selectedDay!))"
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Menlo-Regular", size: 35)
        
        label.text = "\(flag(country: "\(CountrtCodeArray[row].flag)"))+\(CountrtCodeArray[row].Code)"
        
        return label
    }
    
    
  
}

