//
//  manageCard.swift
//  Cabigate
//
//  Created by abdur rehman on 6/13/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class manageCard: UIViewController , UITableViewDelegate , UITableViewDataSource  , UIGestureRecognizerDelegate {

    @IBOutlet weak var tableViewSwift: UITableView!
   
    @IBAction func Back(_ sender: Any) {
        
        VisaCardController.MyVisaCards.removeAll()
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)

    self.tableViewSwift.removeFromSuperview()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        tableViewSwift.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        loadData()
   

    }
    
    
    func loadData(){
        
        VisaCardController.MyVisaCards.removeAll()
        
        VisaCardController.object.fetcAllCard { (result) in
            
            if(result == ""){
                
                self.tableViewSwift.reloadData()
                
            }else{
                
                let controller = alert.object.alertForSignin(title: "OPS!", message: "\(result)")
                
                self.present(controller, animated: true, completion: nil)
                
            }
            
        }
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  VisaCardController.MyVisaCards.count
    }


    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VisaCellView
        
          cell.Configuration(object: VisaCardController.MyVisaCards[indexPath.item])
        
        
        let press = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        press.delegate = self
      
        press.minimumPressDuration = 0.7
        
        cell.addGestureRecognizer(press)
        
        cell.isUserInteractionEnabled = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let cell = self.tableViewSwift.cellForRow(at: indexPath) as!
        VisaCellView
        cell.backgroundView?.backgroundColor = UIColor.black
        
        
    }
    
    func longPress(gestureRecognizer : UILongPressGestureRecognizer){
        
        
        if (gestureRecognizer.state != UIGestureRecognizerState.ended){
            return
        }
        
        let p = gestureRecognizer.location(in: self.tableViewSwift)
        
        let indexPath = self.tableViewSwift.indexPathForRow(at: p) //do whatever you need to do
    
        
        makeDefaultCard.object.MakeCardDefault(CardId: "\(VisaCardController.MyVisaCards[indexPath!.item].cardid)") { (result) in
            
            
            if(result == ""){
                
                let cell = self.tableViewSwift.cellForRow(at: indexPath!) as!
                 VisaCellView
                cell.defaultImg.isHidden = false
              
                self.loadData()
           
                
            }else{
                
                let controller = alert.object.alertForSignin(title: "OPS!", message: "\(result)")
                self.present(controller, animated: true, completion: nil)

                
            }
        }
      
        
    }
    
 
    
    // Override to support conditional editing of the table view.
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {

            let message = UIAlertController(title:"Confermation" , message: "Are you sure you wants to delete this Card Detail", preferredStyle: UIAlertControllerStyle.alert)
            
            let Action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive) { (UIAlertAction) in
                
                VisaCardController.MyVisaCards.remove(at: indexPath.item)
                tableView.deleteRows(at: [indexPath], with: .automatic)
     
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
                
            }
            
            
            message.addAction(Action)
            message.addAction(cancel)
            
            self.present(message, animated: true, completion: nil)
            
            
            deleteVisaCard.object.fetcAllCard(CarId: "\( VisaCardController.MyVisaCards[indexPath.item].cardid)", Results: { (result) in
                
                if(result == ""){
                    
                    
                    
                }else{
                    
                    let controller = alert.instance.alertForSignin(title: "OPS", message: "\(result)")
                    self.present(controller, animated: true, completion: nil)
                }
            })
            
        }
    }
    
    
 
 
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return.lightContent
    }

}
