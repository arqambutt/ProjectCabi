//waitingForDriver
//  waitingForDriver.swift
//  Cabigate
//
//  Created by abdur rehman on 6/28/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import  NVActivityIndicatorView



class waitingForDriver: UIViewController {
    
    @IBOutlet weak var gradiantView: UIViewX!
    var currentColorArrayIndex = -1
    
    @IBOutlet weak var picUploc: UILabel!
    
    @IBOutlet weak var desLoc: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    var colorArray: [(color1: UIColor, color2: UIColor)] = []
    let green = #colorLiteral(red: 0.03529411765, green: 0.6666666667, blue: 0.6901960784, alpha: 1)
    let seeGreen = #colorLiteral(red: 0, green: 0.8039215686, blue: 0.6745098039, alpha: 1)
    let blue = #colorLiteral(red: 0.1294117647, green: 0.5764705882, blue: 0.6901960784, alpha: 1)
    let blueLight = #colorLiteral(red: 0.03137254902, green: 0.3137254902, blue: 0.4705882353, alpha: 1)
    let blueTone = #colorLiteral(red: 0.2666666667, green: 0.6274509804, blue: 0.5529411765, alpha: 1)
    let greenTone = #colorLiteral(red: 0.2352941176, green: 0.8274509804, blue: 0.6784313725, alpha: 1)
    
    @IBOutlet weak var pleaseWait: UILabel!
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picUploc.text = "\(booking.object.currentlocName)"
        
        desLoc.text = "\(booking.object.DeslocName)"
        
        colorArray.append((color1: #colorLiteral(red: 0, green: 0.8039215686, blue: 0.6745098039, alpha: 1) , color2: #colorLiteral(red: 0.03529411765, green: 0.6666666667, blue: 0.6901960784, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.1294117647, green: 0.5764705882, blue: 0.6901960784, alpha: 1) , color2: #colorLiteral(red: 0.4274509804, green: 0.8352941176, blue: 0.9294117647, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.2980392157, green: 0.7215686275, blue: 0.768627451, alpha: 1) , color2: #colorLiteral(red: 0.2352941176, green: 0.8274509804, blue: 0.6784313725, alpha: 1)))
        
        
        gradiantView.alpha = 0.5
        animateBackgroundColor()
        statusLabel.text = "You can cancel Ride within five second after Dispatch"
       
        temp()
        
  
          nearestDriverController.object.socketInstance?.on("passenger_notifier") {data, ack in
            if(nearestDriverController.DriverCsTATUS!.status == "cancel") {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "Map")
                
                self.present(controller, animated: true, completion: nil)
                
            }else {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "waiting")
                
                self.present(controller, animated: true, completion: nil)
            }
            
            
            
        }
        
 
    }
    
    func makeButton(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Map")
        
        self.present(controller, animated: true, completion: nil)
        
    }
    

    func aminateLoading(){
       
        
        let xx = self.view.frame.width / 2
        let yy = self.view.frame.height / 2
        
        animateLabel()
        
        let u =  NVActivityIndicatorView(frame:  CGRect(x: xx - 60, y: yy - 60, width: 120, height: 120), type: .orbit, color: UIColor.black, padding: 2.0)
        u.startAnimating()
        self.view.addSubview(u)
    }
    
    func animateLabel() {
       
        
        
        UIView.animate(withDuration: 2.0 , delay: 2.0, options: [.repeat, .autoreverse], animations: {
            self.pleaseWait.alpha = 1
            
        }) { (True) in
            self.pleaseWait.alpha = 0
        }
        
     
    }
    
    func animateBackgroundColor(){
        
        currentColorArrayIndex = currentColorArrayIndex == (colorArray.count - 1) ? 0 : currentColorArrayIndex + 1
        UIView.transition(with: self.gradiantView, duration: 4, options: [.transitionCrossDissolve], animations: {
            self.gradiantView.firstColor = self.colorArray[self.currentColorArrayIndex].color1
            self.gradiantView.secondColor = self.colorArray[self.currentColorArrayIndex].color2
        }) {(success) in
            self.animateBackgroundColor()
        }
    }
    
    
    func temp (){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(makeButton))
        pleaseWait.isUserInteractionEnabled = true
        pleaseWait.addGestureRecognizer(tap)
        pleaseWait.backgroundColor = UIColor.white
        pleaseWait.text = "Cancel Booking"
        pleaseWait.textColor = UIColor(displayP3Red: 6/255, green: 191/255, blue: 195/255, alpha: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            
            self.pleaseWait.alpha = 0
            
            self.pleaseWait.isUserInteractionEnabled = false
            
            self.pleaseWait.backgroundColor = UIColor.clear
            self.pleaseWait.text = "Please Wait!"
             self.statusLabel.text = "We are looking for the best near by car for you"
            self.pleaseWait.textColor = UIColor.white
            self.aminateLoading()
     
            bookingClass.object.bookingFunction { (result) in
                
                
                if(result == ""){
                    
                    
                    
                    
                }else if (result == "No") {
                    
                    
                    let message = UIAlertController(title:"Sorry :(", message: "We are unable to dispatch your Request, Please make sure you have chosen car and payment method", preferredStyle: UIAlertControllerStyle.alert)
                    
                    
                    
                    let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: { (UIAlertAction) in
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "Map")
                        
                        self.present(controller, animated: true, completion: nil)
                        
                        
                    })
                    let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: { (UIAlertAction) in
                        
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "Map")
                        
                        self.present(controller, animated: true, completion: nil)
                        
                        
                        
                    })
                    
                    message.addAction(ok)
                    message.addAction(cancel)
                    self.present(message, animated: true, completion: nil)
                    
                }
                
            }
        
        
        }
        
        
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.default
    }
    
}



class UIViewX: UIView{
    
    @IBInspectable var firstColor: UIColor = UIColor.white{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.white{
        didSet{
            updateView()
        }
    }
    
    var horizontalGradiant: Bool = false {
        didSet{
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        
        if (horizontalGradiant){
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 0.5, y: 0.0)
        }else{
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
        
    }
    
    
}

