//
//  walletController.swift
//  carcabigateFinal
//
//  Created by Arqam Butt on 22/07/2017.
//  Copyright © 2017 Arqam Butt. All rights reserved.
//

import UIKit

class walletController: UIViewController, UITableViewDelegate, UITableViewDataSource , PayPalPaymentDelegate{
    
    
    static var object = walletController()
    
    @IBOutlet weak var MytABLE: UITableView!

    let label = ["Credit Card","PayPal","Cash"]
    let SecondLabel = ["Add Credit Card","PayPal pay!","History"]
    let image = ["credit-card","paypal (1)","pound-app"]
    
    var resultText = "" // empty
    var payPalConfig = PayPalConfiguration()
    
    
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        booking.object.paypalPass = true
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let Controller = storyBoard.instantiateViewController(withIdentifier: "Map")
            self.present(Controller, animated: true, completion: nil)
            
            self.resultText = completedPayment.description
          
        })
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        
        
        if(booking.object.RideNowBtnPress == true){
            booking.object.RideNowBtnPress = false
            paypalPaymentSystem()
          
        }
        
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        
        // hashim
        payPalConfig.merchantName = "Cab Point by Cabigate!"
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .both
        
        
        

        
        
    }
    
    
    func paypalsubSystem(afre:String){
        // Optional: include multiple items
       let item1 = PayPalItem(name: "Cab Point Ride Fare!", withQuantity: 1, withPrice: NSDecimalNumber(string: "\(afre)"), withCurrency: "GBP", withSku: "Hip-0037")
      
        
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.0")
        let tax = NSDecimalNumber(string: "0.0")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "GBP", shortDescription: "Cab Point Ride Fare!", intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }
        //////
            }
    
    func paypalPaymentSystem(){
        
        var fare = booking.object.fareEstimate
        
        
        if(fare == ""){
            fare = "1.0"
        

            paypalsubSystem(afre: fare)
        }else {
            
            paypalsubSystem(afre: booking.object.fareEstimate)
        }
            
        
        
  
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == 0){
            
            return "SELECT DEFAULT PAYMENT METHOD"
            
        }else {
            
            return "ADD PAYMENT METHOD"
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
     
        
        view.tintColor = UIColor(displayP3Red: 6/255, green: 191/255, blue: 195/255, alpha: 1)
      
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor.white
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! walletTableViewCell
    cell.rightTcik.isHidden = true
    let cheak =  UserDefaults.standard.value(forKey: "paymentMethod")
        
       
     
        if(indexPath.section == 0){
    
            if(cheak != nil){
                
                if(String(describing: cheak!) == "craditCard" ){
                    if(indexPath.row == 0){
                      
                         cell.rightTcik.isHidden = false
                    }
                   
                    
                }else if (String(describing: cheak!) == "paypal"){
                    if(indexPath.row == 1){
                        
                        cell.rightTcik.isHidden = false
                    }
                    
                    
                }else if (String(describing: cheak!) == "cash"){
                    if(indexPath.row == 2){
                        
                        cell.rightTcik.isHidden = false
                    }
                    
                    
                }else {
                  
                    cell.rightTcik.isHidden = true
                }
                
            }
            
            cell.headingLabel?.text = label[indexPath.row]
            cell.labelImages?.image = UIImage(named: image[indexPath.row])
        }
        else {
         
            cell.headingLabel?.text = SecondLabel[indexPath.row]
            let images = image[indexPath.row]
            cell.labelImages?.image = UIImage(named: images)
        }
        
    
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(indexPath.section == 1){
           
            if(indexPath.row == 0){
                
                
                let controller = storyboard?.instantiateViewController(withIdentifier: "AddCoustomCard") as! paymentController
                
                self.navigationController?.pushViewController(controller, animated: true)
                
                
                
            }else if (indexPath.row == 1) {
                
                
                paypalPaymentSystem()
                
            }
            else if (indexPath.row == 2) {
                
                let controller = storyboard?.instantiateViewController(withIdentifier: "CardTable") as! manageCard
                
                self.navigationController?.pushViewController(controller, animated: true)
                //CardTable
            }
        }else if (indexPath.section == 0){
            
            if(indexPath.row == 0){
                
                UserDefaults.standard.set("craditCard", forKey: "paymentMethod")
             MytABLE.reloadData()
            }else if (indexPath.row == 1){
                 UserDefaults.standard.set("paypal", forKey: "paymentMethod")
                 MytABLE.reloadData()
            }else {
                 UserDefaults.standard.set("cash", forKey: "paymentMethod")
                 MytABLE.reloadData()
            }
            
            
            
        }
        
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    



}
