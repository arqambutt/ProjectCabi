//
//  changePhone.swift
//  Cabigate
//
//  Created by abdur rehman on 7/13/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class changePhone: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    class countryCodeClass {
        
        var flag:String = ""
        var Code:String = ""
        
        init(flag:String , Code:String) {
            
            self.flag = flag
            self.Code = Code
            
        }
    }
    
    var code:String = "44"
    
    var CountrtCodeArray = [countryCodeClass]()
    
    var selectedDay: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    countryCode.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(RemoveView))
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
//        
//        let countryCodeTap = UITapGestureRecognizer(target: self, action: #selector(countryCodeFun))
//        countryCode.addGestureRecognizer(countryCodeTap)
//        countryCode.isUserInteractionEnabled = true
        createDayPicker()
        createToolbar()
        FetchCountryCode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func RemoveView(){
        
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func changeNumber(_ sender: Any) {
        
    
        
        if(countryCode.text! != "" && phoneNumber.text! != "" ){
            
            
            let number = "+\(code)\( phoneNumber.text!)"
            
            print(number)
            
            changePhoneNumber.object.verifyPhoneNumber(phonenumber: number , result: { (result) in
                
                if(result == ""){
                    
                    let storyboad = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboad.instantiateViewController(withIdentifier: "Verify")
                    self.present(controller, animated: true, completion: nil)
                    
                }else{
                    
                    
                    let u = alert.object.alertForSignin(title: "Sorry ;(", message: "Phone number is not valid")
                    
                    self.present(u, animated: true, completion: nil)
                }
                
            })
        }else {
            
            let u = alert.object.alertForSignin(title: "Alert!", message: "Please make sure you have enter Your phone number")
            
            self.present(u, animated: true, completion: nil)
            
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.resignFirstResponder()
        return true
    }
    
    
    
    func FetchCountryCode() {
        
        CountrtCodeArray.removeAll()
        
        
        DispatchQueue.global(qos: .background).async {
            let request = NSMutableURLRequest(url: NSURL(string: "http://country.io/phone.json")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                if(error != nil){
                    
                    
                    
                }else {
                    
                    do{
                        DispatchQueue.main.async {
                            do {
                                
                                print(data!)
                                
                                let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                                
                                
                                
                                
                                for i in temp {
                                    
                                    
                                    self.CountrtCodeArray.append(countryCodeClass.init(flag: i.key as! String, Code: String(describing: i.value)))
                                }
                                
                            }catch {
                                print(error)
                            }
                        }
                    }
                }
                
            })
            
            dataTask.resume()
            
        }
    }
    
    
    func createDayPicker() {
        
        let dayPicker = UIPickerView()
        dayPicker.delegate = self as UIPickerViewDelegate
        
     countryCode.inputView = dayPicker
        
        dayPicker.backgroundColor = .black
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
        
        countryCode.inputAccessoryView = toolBar
    }
 
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    

}

extension changePhone: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        countryCode.text = "\(flag(country:flagg))+\(String(describing: selectedDay!))"
        
        
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


