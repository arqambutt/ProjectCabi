//
//  calender.swift
//  Cabigate
//
//  Created by abdur rehman on 7/7/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class calender: UIViewController   {
    
   

    @IBOutlet weak var calender: UIDatePicker!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
  calender.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(performDissegue))
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true
     
    }

    
    
    @IBAction func confermRide(_ sender: Any) {
        
        
       
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let Controller = storyBoard.instantiateViewController(withIdentifier: "payment")
        self.present(Controller, animated: true, completion: nil)
    
    }
    
    
    

    func performDissegue(){
        
    dismiss(animated: true, completion: nil)
        
    }
    
    
    func dateChanged(_ sender: UIDatePicker) {
        let componenets = Calendar.current.dateComponents([.year, .month, .day , .hour , .minute , .second], from: sender.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year , let minute = componenets.minute ,  let hour = componenets.hour , let second = componenets.second {
          booking.object.pic_Date = "\(year)-\(month)-\(day) \(hour):\(minute):\(second)"
  
            print(booking.object.pic_Date)
            
        }
    }
    

}
