//
//  HistoryView.swift
//  Cabigate
//
//  Created by abdur rehman on 6/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import GoogleMaps


typealias data = (_ msg:String)-> Void
class HistoryView: UIViewController {

    @IBOutlet weak var needhelp: UILabel!
    
    @IBOutlet weak var backButtonImg: UIImageView!
    
    @IBOutlet weak var NeedHelpLabel: UILabel!
    
   
    @IBOutlet weak var CV: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Map
        needhelp.layer.borderWidth.add(2)
        needhelp.layer.cornerRadius = needhelp.frame.width / 10
        needhelp.layer.borderColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1).cgColor
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonPress))
        backButtonImg.isUserInteractionEnabled = true
        backButtonImg.addGestureRecognizer(tap)
        
        ImportHistory.object.FetchHistory { (results) in
            
            
            if(results == "Not an valid Email and Password"){
                
                let controller = alert.object.alertForSignin(title: "Alert", message: "unabletofindanything")
                self.present(controller, animated: true, completion: nil)
                
            }else if (results == ""){
 
                self.CV.reloadData()
//                           
        }
        

    }
    }

    func backButtonPress(){
        
        let storyBoad = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoad.instantiateViewController(withIdentifier: "Map")
        self.present(controller, animated: true, completion: nil)
        
    }
  

}

extension HistoryView :UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ImportHistory.historyArray.count
    }
    
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HistoryCell
        
        cell.configurationofCell(object: ImportHistory.historyArray[indexPath.item])
        
        return cell
    }
    
    
func makePolyLine(obj:historyclass, result:@escaping data) {
        
        DispatchQueue.global(qos: .background).async {
            
            var origin:String = ""
            if (obj.pickup_lng! == "" || obj.pickup_lat! == ""){
                
                   origin = "\(0.0),\(0.0)"
                
            }else{
                
                  origin = "\(Double(obj.pickup_lng!)!),\(Double(obj.pickup_lng!)!)"
            }
            
     
        
            print(origin)
            
            
            var destination:String = ""
            if (obj.pickup_lng! == "" || obj.pickup_lat! == ""){
                
                destination = "\(0.0),\(0.0)"
                
            }else{
                
                destination = "\(Double(obj.pickup_lng!)!),\(Double(obj.pickup_lng!)!)"
            }
            
            
  
        
        let todoEndpoint: String = "https://maps.googleapis.com/maps/api/directions/json?origin=\( origin)&destination=\(destination)&key=AIzaSyB6D54NhJotKJplTKlzE8RZDlImJY1hmtY"
        
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
    
            
            // make the request
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                // do stuff with response, data & error here
                
                
                do {
                    
                    let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    
                    DispatchQueue.main.async {
                        
                        let yes = temp["routes"] as! NSArray
                        
                        let polyline = yes.value(forKey: "overview_polyline") as! NSArray
                        
                        let point = polyline.value(forKey: "points") as! NSArray
                        
                        let path = GMSPath.init(fromEncodedPath: point[0] as! String)
                        
                        let polylinetwo = GMSPolyline.init(path: path)
                
                        print(polylinetwo)
                        return result("")
                    }
                    
                } catch {
                    print(error)
                }
                
                 return result("notnow")
                
            })
            
            task.resume()
        }
    }
    

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
