//
//  paypal.swift
//  Cabigate
//
//  Created by abdur rehman on 6/12/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import Foundation


class paypal: UIViewController , CardIOPaymentViewControllerDelegate , UITextFieldDelegate {

    
    
    @IBOutlet weak var Back: UIImageView!
    
    @IBOutlet weak var craditCardNumber: UITextField!
    
    @IBOutlet weak var month: UITextField!
    
    @IBOutlet weak var year: UITextField!
    
    @IBOutlet weak var ccv: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
          CardIOUtilities.preload()
        
        craditCardNumber.delegate  = self
        month.delegate = self
        year.delegate = self
        ccv.delegate = self
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(Exit))
        Back.isUserInteractionEnabled = true
        Back.addGestureRecognizer(tap)
       
    
    }
    
    
    func Exit(){
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Map")
        present(controller, animated: true, completion: nil)
        
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == craditCardNumber){
            
            craditCardNumber.text = ""
            
        }else if(textField == month){
            
            month.text = ""
         
        }else if(textField == year){
            
            year.text = ""
            
        }else if(textField == ccv){
            
            ccv.text = ""
            
        }
    }


    
    @IBAction func MenualCardEntery(_ sender: Any) {
        
        
   CardEntery(CardNumber:craditCardNumber.text! , month: month.text!, year: year.text!, ccv: ccv.text!)
        
        
        
    }
    

    
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
      
        paymentViewController.dismiss(animated: true, completion: nil)
        
        Addcard.object.performSavingCard(cardNumber: cardInfo.cardNumber, cvv: cardInfo.cvv, expiryMonth: String(cardInfo.expiryMonth), expiryYear: String(cardInfo.expiryYear)) { (results) in
            
            if(results == ""){
                
                let a = alert.object.alertForSignin(title: "Congratulation", message: "Your card has been added Sucessfully")
                
            self.present(a, animated: true, completion: nil)
                
            }else {
                
                let b = alert.object.alertForSignin(title: "Alert!", message: "\(results)")
                
                self.present(b, animated: true, completion: nil)
                
                
            }
            
            
            
        }
    }

    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func CardEntery (CardNumber:String , month:String , year:String , ccv:String ){
        
        
        if(CardNumber != "" && month != "" && year != "" && ccv != ""){
            
            Addcard.object.performSavingCard(cardNumber: CardNumber, cvv: ccv, expiryMonth: month, expiryYear: year) { (results) in
                
                if(results == ""){
                    
                    let a = alert.object.alertForSignin(title: "Congratulation", message: "Your card has been added Sucessfully")
                    
                    self.present(a, animated: true, completion: nil)
                    
                }else {
                    
                    let b = alert.object.alertForSignin(title: "Alert!", message: "\(results)")
                    
                    self.present(b, animated: true, completion: nil)
                    
                    
                }
                
                
                
            }
            
        }else {
            
            let a = alert.instance.alertForSignin(title: "Alert!", message: "Make sure you have enter the erite information ")
            
            self.present(a, animated: true, completion: nil)
        }
        
    }
    

    
 
    
    @IBAction func scanCard(_ sender: Any) {
        
    
     
        
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.collectCardholderName = true
        cardIOVC?.guideColor = UIColor.red
        cardIOVC?.collectCVV = true
        present(cardIOVC!, animated: true, completion: nil)
        
        
    }
    
    
    
   
    
    
    
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.resignFirstResponder()
        return true
    }
    

  

}
