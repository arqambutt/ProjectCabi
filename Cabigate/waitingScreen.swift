//
//  waitingScreen.swift
//  Cabigate
//
//  Created by abdur rehman on 6/22/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import SDWebImage
import MessageUI
import GoogleMaps
import GooglePlaces
import UserNotifications
import CoreLocation
class waitingScreen: UIViewController  , GMSMapViewDelegate {
    
    
    var JobId = ""
    var object :socketDriver? = nil
    var oldFPolyline:GMSMutablePath? = nil
    var cheak = true
    var polylineArrayValues = [CLLocationCoordinate2D]()
    

    @IBOutlet weak var needHelo: UIButton!
    
    @IBAction func needHelp(_ sender: Any) {
    }
    static var instance  = waitingScreen()


    @IBOutlet weak var picUplOcation: UILabel!
    @IBOutlet weak var desLocation: UILabel!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var belowView: UIView!
    @IBOutlet weak var picTwo: UIImageView!
    @IBOutlet weak var picOne: UIImageView!
    @IBOutlet weak var backViewTwo: UIView!
    @IBOutlet weak var backViewOne: UIView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ContectDriver: UIButton!
    @IBOutlet weak var cancelTrip: UIButton!
    @IBOutlet weak var vehacialName: UILabel!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var customMap: GMSMapView!
    @IBOutlet weak var DriverStatus: UILabel!
   
    
    
    @IBOutlet weak var minFairView: UIView!
    @IBOutlet weak var minCarLabelView: UIView!
    @IBOutlet weak var minEtaView: UIView!
    @IBOutlet weak var minBottomView: UIView!
    @IBOutlet weak var minStarView: UIView!
    @IBOutlet weak var ImgBackView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var minpounds: UILabel!
    @IBOutlet weak var minNamming: UILabel!
    @IBOutlet weak var minCar: UILabel!
    @IBOutlet weak var minTimming: UILabel!
    @IBOutlet weak var minRating: UILabel!
    
  
    var DriverIdShare = ""


    func callView(Name:String){
        
        
        let storyBord = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBord.instantiateViewController(withIdentifier: "\(Name)")
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var TopButton: UIButton!
    lazy var button = false
    @IBAction func hideButton(_ sender: Any) {
        
        if(button == false){
            
   
            
            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
                
                
               self.TopView.frame.origin.y = self.view.frame.height/8 - self.TopView.frame.height
                
             
                
               self.belowView.frame.origin.y = self.belowView.frame.origin.y + self.belowView.frame.height
                
            }, completion: nil)
            
            TopButton.setTitle("Show", for: UIControlState.normal)
            button = true
        }else {
            
            
            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
                
                
                self.TopView.frame.origin.y = self.view.frame.height/4 - self.TopView.frame.height
             
                self.belowView.frame.origin.y = self.view.frame.height - self.belowView.frame.height
               
                
            }, completion: nil)
            
            TopButton.setTitle("Hide", for: UIControlState.normal)
            button = false
        }
    }
    
    
    
    func myLocation()->CLLocation {
        var location:CLLocation? = nil
        let Manager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            Manager.startUpdatingLocation()
        }
        if (Manager.location?.coordinate.longitude != nil){
            
            location = CLLocation(latitude: (Manager.location!.coordinate.latitude), longitude: (Manager.location!.coordinate.longitude))
        }
    
        return location!
    }
    
    
    func DriverStatusFun(Staus:String){
        
        
        
        switch Staus {
            
        case "callout":
            DriverStatus.text = "Driver is On his Way!"
            break
        case "waiting":
            DriverStatus.text = "Arrived & Waiting!"
            break
        case "pob":
            DriverStatus.text = "Passenger On Board!"
            break
        case "cancel":
            DriverStatus.text = "Ride cancel!"
            break
            
        default:
            DriverStatus.text = "Connecting"
            break
        }
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
       // SetValuetoShare(type: "remove")
        

        viewHelper.instance.view_circle(views:ImgBackView)
        viewHelper.instance.view_circle(views:imgView)
        viewHelper.instance.view_circle(views:backViewOne)
        viewHelper.instance.view_circle(views:backViewTwo)
        viewHelper.instance.view_circle(views:picOne)
        viewHelper.instance.view_circle(views:picTwo)
   
        
        viewHelper.instance.view_circle(views:needHelo)
        viewHelper.instance.border_Function(views: minFairView, colorName: "white")
        viewHelper.instance.border_Function(views: minCarLabelView, colorName: "white")
        viewHelper.instance.border_Function(views: minEtaView, colorName: "white")
        viewHelper.instance.border_Function(views: minStarView, colorName: "white")
        viewHelper.instance.border_Function(views: needHelo, colorName: "blue")
        
       self.belowView.frame.origin.y = self.view.frame.height - self.belowView.frame.height
      
     
        
     
        
        let result = UserDefaults.standard.value(forKey: "State")
        
        if let temp = result as? NSDictionary{
            
            let u  = (temp["status"] as? String)!
      
            if(u == ""){
                
        if(nearestDriverController.DriverCsTATUS!.driver_image != "")
        {
            if(nearestDriverController.DriverCsTATUS!.status == "callout"){
                
                
                // setting inital polyline for call out
                
                self.MPolyLineWithcordinate(picLat: "\(nearestDriverController.DriverCsTATUS!.driver_lat)", picLon: "\(nearestDriverController.DriverCsTATUS!.driver_lng)", droplat: "\(nearestDriverController.DriverCsTATUS!.pickup_lat)", dropLong: "\(nearestDriverController.DriverCsTATUS!.pickup_lng)")
                
            }
            
                
                // setting inital values
                SetValues()
                
                //Setting Initail Markers
            
            
            if(nearestDriverController.DriverCsTATUS!.pickup_lat != ""){
                
                SetInitialMarker(lat: nearestDriverController.DriverCsTATUS!.pickup_lat, lon: nearestDriverController.DriverCsTATUS!.pickup_lng, imgUrl: "", asserts: "Pic")
            }
                
            
            if (nearestDriverController.DriverCsTATUS!.dropoff_lat != "") {
              
                SetInitialMarker(lat: nearestDriverController.DriverCsTATUS!.dropoff_lat, lon: nearestDriverController.DriverCsTATUS!.dropoff_lng, imgUrl: "", asserts: "Des")
                
            }
                
                
          
            if( nearestDriverController.DriverCsTATUS!.driver_lat != ""){
                
                SetInitialMarker(lat: nearestDriverController.DriverCsTATUS!.driver_lat, lon: nearestDriverController.DriverCsTATUS!.driver_lng, imgUrl: nearestDriverController.DriverCsTATUS!.vehicle_image, asserts: "")
            }
                
            
                
            }
            
            
            
            
                }
                   else {
                
                nearestDriverController.object.SocketRequest(Socket: { (result) in
   
                  
                    
                })
                
                
                
                if( u == "pob"){
                    
                    
                   let MyLocation =  myLocation()
                    
                    MPolyLineWithcordinate(picLat: "\(MyLocation.coordinate.latitude)", picLon: "\(MyLocation.coordinate.longitude)", droplat: (temp["dropoff_lat"] as? String)!, dropLong: (temp["dropoff_lng"] as? String)!)
                    
                }
                
               // uper Values
                self.picUplOcation.text = (temp["pickup"] as? String)!
                self.desLocation.text = (temp["dropoff"] as? String)!
                self.status.text = "\(u)"
                self.vehacialName.text =  (temp["vehicle_name"] as? String)!
                self.driverName.text = (temp["driver_name"] as? String)!
                self.rating.text = (temp["driver_rating"] as? String)!
                self.carModel.text = (temp["vehicle_model"] as? String)!
                self.DriverIdShare = (temp["driver_id"] as? String)!
                self.JobId = (temp["jobid"] as? String)!
          
                
              
                // min Values
                self.minTimming.text = (temp["vehicle_model"] as? String)!
                self.minCar.text = (temp["vehicle_name"] as? String)!
                self.minNamming.text = (temp["driver_name"] as? String)!
                self.minRating.text = (temp["driver_rating"] as? String)!
                self.minpounds.text = u
                
                
                
                
                SetInitialMarker(lat: (temp["driver_lat"] as? String)!, lon: (temp["driver_lng"] as? String)!, imgUrl: (temp["vehicle_image"] as? String)!, asserts: "")
                SetInitialMarker(lat: (temp["pickup_lat"] as? String)!, lon: (temp["pickup_lng"] as? String)!, imgUrl: "", asserts: "Pic")
                SetInitialMarker(lat: (temp["dropoff_lat"] as? String)!, lon:(temp["dropoff_lng"] as? String)!, imgUrl: "", asserts: "Des")
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: NSURL(string: "\((temp["driver_image"] as? String)!)")! as URL, options: [.highPriority], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in

                    self.picOne.image = IMG
                    self.imgView.image = IMG
  
                })

                SDWebImageManager.shared().imageDownloader?.downloadImage(with: NSURL(string: "\((temp["vehicle_image"] as? String)!)")! as URL, options: [.highPriority ], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
                    
                    self.picTwo.image = IMG
                    
                })
            }
        }
 
        nearestDriverController.object.socketInstance?.on("passenger_notifier") {data, ack in
            

            if(nearestDriverController.DriverCsTATUS!.status == "connecting") {
              
            }
                
                
            else if(nearestDriverController.DriverCsTATUS!.status == "cancel") {
                
                self.SetValuetoShare(type: "remove")
                self.DriverStatusFun(Staus: "cancel")
                self.callView(Name: "Map")
                
            }
            else if(nearestDriverController.DriverCsTATUS!.status == "waiting") {
               
                self.SetValues()
                self.DriverStatusFun(Staus: "waiting")
                self.RemoveOldPolyline()
                
            }
            else if(nearestDriverController.DriverCsTATUS!.status == "pob") {
                
                
                self.SetValues()
                self.DriverStatusFun(Staus: "pob")
                self.MPolyLineWithcordinate(picLat: "\(nearestDriverController.DriverCsTATUS!.driver_lat)", picLon: "\(nearestDriverController.DriverCsTATUS!.driver_lng)", droplat: "\(nearestDriverController.DriverCsTATUS!.dropoff_lat)", dropLong: "\(nearestDriverController.DriverCsTATUS!.dropoff_lng)")
                
            }
            else if(nearestDriverController.DriverCsTATUS!.status == "complete") {
           
                self.DriverStatusFun(Staus: "complete")
                self.RemoveOldPolyline()
                self.callView(Name: "congo")
                self.SetValuetoShare(type: "remove")
                
            }
            else if(nearestDriverController.DriverCsTATUS!.status == "callout") {
               
                self.SetValues()
                
                self.MPolyLineWithcordinate(picLat: "\(nearestDriverController.DriverCsTATUS!.driver_lat)", picLon: "\(nearestDriverController.DriverCsTATUS!.driver_lng)", droplat: "\(nearestDriverController.DriverCsTATUS!.pickup_lat)", dropLong: "\(nearestDriverController.DriverCsTATUS!.pickup_lng)")
   
            }
        }
        nearestDriverController.object.socketInstance?.on("locationupdater") {data, ack in
            
            
            if(self.DriverIdShare == nearestDriverController.nearestdriver!.driverid ) {
                
                self.changeMarkerPosition(obj: nearestDriverController.nearestdriver!)
                self.removeTrackingPolyilne(Dlat: nearestDriverController.nearestdriver!.lat, Dlon: nearestDriverController.nearestdriver!.lon)
            }
        }
    }
    

    
    
    
    
    func SetInitialMarker(lat:String , lon:String , imgUrl:String  ,asserts:String) {
        
        
        let newMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!))
        
        newMarker.icon = nil
    
        if(asserts == ""){
            
        let managerr:SDWebImageManager = SDWebImageManager.shared()
        managerr.imageDownloader?.downloadImage(with: NSURL(string: imgUrl)! as URL, options: [.highPriority  , .progressiveDownload , .useNSURLCache], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
            
            newMarker.icon = ViewController.object.scaleImageToSize(img: IMG!, size: CGSize(width: 40.0, height: 40.0))
            self.oldMarker = newMarker
            
             self.customMap.camera = GMSCameraPosition.camera(withLatitude: Double(lat)!,
                                                  longitude: Double(lon)!,
                                                  zoom: 14)
            
        })
        }else {

            if(asserts == "Pic"){
                newMarker.icon = nil
                newMarker.icon = ViewController.object.scaleImageToSize(img: UIImage(named:"green")!, size: CGSize(width: 40.0, height: 40.0))
                
            }else if (asserts == "Des") {
                newMarker.icon = nil
                  newMarker.icon = ViewController.object.scaleImageToSize(img: UIImage(named:"red")!, size: CGSize(width: 40.0, height: 40.0))
                
            }

        }

        newMarker.map = customMap
        
        
    }
    


    var oldPolyline:GMSPolyline? = nil
    
    func RemoveOldPolyline() {
        
        if(oldPolyline != nil){
        
            oldPolyline?.map = nil
        }
        
    }
    var oldMarker:GMSMarker? = nil
    
    func RemoveOldmarker() {
        
        
        if(oldMarker != nil){
            
            oldMarker?.map = nil
        }
        
    }
    
    
    
    func MPolyLineWithcordinate(picLat:String , picLon:String , droplat:String , dropLong:String){
        
        if(picLat != "" && picLon != "" && droplat != "" && dropLong != "" ){
            
       
        
        if(cheak == true){
        polylineArrayValues.removeAll()
        oldFPolyline = nil
        RemoveOldPolyline()
            
            cheak = false
        
            
            let todoEndpoint: String = "https://maps.googleapis.com/maps/api/directions/json?origin=\( picLat),\(picLon)&destination=\(droplat),\(dropLong)&key=AIzaSyB6D54NhJotKJplTKlzE8RZDlImJY1hmtY"
        
            
            guard let url = URL(string: todoEndpoint) else {
                print("Error: cannot create URL")
                return
            }
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                
                if(error != nil){
                    
                    print(error!)
                }else {
                    
                do{
    
                    let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    
                    
                        
                        let yes = temp["routes"] as! NSArray
                        let polyline = yes.value(forKey: "overview_polyline") as! NSArray
                        let point = polyline.value(forKey: "points") as! NSArray
                    
                    
                    
                    
            
                    let polylin = Polyline(encodedPolyline: point[0] as! String)
                    for i in polylin.coordinates! {
                        self.polylineArrayValues.append(CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude) )
                    }
         
                    
                    
                    
                    
                            if(point.count != 0){
                            
                            let u = GMSMutablePath(fromEncodedPath: point[0] as! String)
                            let rectangle = GMSPolyline(path: u!)
                            rectangle.strokeWidth = 4
                            rectangle.strokeColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1)
                            
                                
                            self.oldFPolyline = u
                            self.oldPolyline = rectangle
                            rectangle.map = self.customMap
    
                    }
                    self.cheak = true
                    
                }
                    
                catch {
  
                }
                }
            })
          task.resume()
    
    
        }
            
        }
    }
    
    

    
    
    func removeTrackingPolyilne(Dlat:String , Dlon:String) {

        
        
        if(polylineArrayValues.count != 0){
          
            
            
            let drivercordinate = CLLocation(latitude: Double(Dlat)!, longitude: Double(Dlon)!)
            
            let polylinecordinate = CLLocation(latitude:  polylineArrayValues[0].latitude, longitude:  polylineArrayValues[0].longitude)
            

            if(drivercordinate.distance(from: polylinecordinate) < 5){
                
                RemoveOldPolyline()
                
                let u = oldFPolyline
                u?.removeCoordinate(at: UInt(0))
                polylineArrayValues.remove(at: 0)
                let rectangle = GMSPolyline(path: u!)
                rectangle.strokeWidth = 4
                rectangle.strokeColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1)
                self.oldFPolyline = u
                self.oldPolyline = rectangle
                rectangle.map = self.customMap
                
            }else if (drivercordinate.distance(from: polylinecordinate) > 70){
                
                
                let result = UserDefaults.standard.value(forKey: "State")
                
                if let temp = result as? NSDictionary{
                    
                    let u  = (temp["status"] as? String)!
                    
                    
                    if(u == "pob"){
                        
                        let MyLocation =  myLocation()
                        
                        MPolyLineWithcordinate(picLat: "\(MyLocation.coordinate.latitude)", picLon: "\(MyLocation.coordinate.longitude)", droplat: (temp["dropoff_lat"] as? String)!, dropLong: (temp["dropoff_lng"] as? String)!)
                        
                    }else if (u == "callout"){
                       
                        self.MPolyLineWithcordinate(picLat: (temp["driver_lat"] as? String)!, picLon: "\(nearestDriverController.DriverCsTATUS!.driver_lng)", droplat: "\(nearestDriverController.DriverCsTATUS!.pickup_lat)", dropLong: "\(nearestDriverController.DriverCsTATUS!.pickup_lng)")
                        
                        
                    }
                }
               
                
                
            }
            
        }

    }
    
    

    
    var tempMarker:GMSMarker? = nil
    
    func removeOld(){
        
        tempMarker?.map = nil
        
    }
    
    
    func changeMarkerPosition(obj:socketDriver){
        
        
        if(obj.lat != ""){
        
        
        let position = CLLocationCoordinate2D(latitude: Double(obj.lat)!, longitude: Double(obj.lon)!)
        let marker = GMSMarker(position: position)
        
        
        
        let result = UserDefaults.standard.value(forKey: "State")
        if let temp = result as? NSDictionary{
        if((temp["vehicle_image"] as? String)! != ""){
      
      
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: NSURL(string: (temp["vehicle_image"] as? String)!)! as URL, options: [.highPriority  , .progressiveDownload , .useNSURLCache], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
                    
                    marker.icon = ViewController.object.scaleImageToSize(img: IMG!, size: CGSize(width: 40.0, height: 40.0))
                    
       
                })
            }
        }
        RemoveOldmarker()
       
        marker.position = position
        marker.isFlat = true
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)

        if(tempMarker != nil){
           
            marker.rotation = CLLocationDegrees(ViewController.object.getHeadingForDirection(fromCoordinate: (tempMarker!.position), toCoordinate: position))
            
        }
     
            removeOld()
            self.tempMarker = marker
            marker.map = self.customMap
    }
    }
    

    

    func SetValues(){
        
        
       
            
        let imgurl:NSURL? = NSURL(string: nearestDriverController.DriverCsTATUS!.driver_image)!
        
        
        
        let manager:SDWebImageManager = SDWebImageManager.shared()
        manager.imageDownloader?.downloadImage(with: imgurl! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload , .useNSURLCache], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
            
            self.picOne.image = IMG
           self.imgView.image = IMG
            
            
        })
        
        let imgurll:NSURL? = NSURL(string: "\(String(describing: nearestDriverController.DriverCsTATUS!.vehicle_image))")!
        
        
        
        let managerr:SDWebImageManager = SDWebImageManager.shared()
        managerr.imageDownloader?.downloadImage(with: imgurll! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload , .useNSURLCache], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
            
            self.picTwo.image = IMG
            
            
        })

         self.minTimming.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.vehicle_model))"
         self.minCar.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.vehicle_name))"
         self.minNamming.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.driver_name))"
         self.minRating.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.driver_rating)) Star"
         self.minpounds.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.status))"
        
        
        self.picUplOcation.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.pickup))"
        self.desLocation.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.dropoff))"
        self.vehacialName.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.vehicle_name))"
        self.minCar.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.vehicle_name))"
        self.driverName.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.driver_name))"
        self.minNamming.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.driver_name))"
        self.rating.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.driver_rating))"
        self.minRating.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.driver_rating))"
        self.carModel.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.vehicle_model))"
        self.status.text = "\(String(describing: nearestDriverController.DriverCsTATUS!.status))"
        
    
        
     SetValuetoShare(type: "Set")
        
        
        
        
    }
    
    
    

    
    
    
    
    @IBAction func cancelTrip(_ sender: Any) {
        
        self.callView(Name: "CancelBooking")

    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func contectDriver(_ sender: Any) {
        
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let Controller = storyBoard.instantiateViewController(withIdentifier: "contectdriver")
        self.present(Controller, animated: true, completion: nil)
        
        
        
    }
    
    
    

    

    func SetValuetoShare(type:String){
        
        if(type == "Set"){
            

            
            let dict:[String:String] = ["jobid":"\(nearestDriverController.DriverCsTATUS!.jobid)" , "status":"\(nearestDriverController.DriverCsTATUS!.status)" ,"driver_id":"\(nearestDriverController.DriverCsTATUS!.driver_id)" ,"driver_name":"\(nearestDriverController.DriverCsTATUS!.driver_name)" ,"driver_contact":"\(nearestDriverController.DriverCsTATUS!.driver_contact)" ,"driver_image":"\(nearestDriverController.DriverCsTATUS!.driver_image)" ,"driver_rating":"\(nearestDriverController.DriverCsTATUS!.driver_rating)" ,"vehicle_id":"\(nearestDriverController.DriverCsTATUS!.vehicle_id)" ,"vehicle_name":"\(nearestDriverController.DriverCsTATUS!.vehicle_name)"  ,"vehicle_model":"\(nearestDriverController.DriverCsTATUS!.vehicle_model)", "vehicle_plate":"\(nearestDriverController.DriverCsTATUS!.vehicle_plate)","vehicle_image":"\(nearestDriverController.DriverCsTATUS!.vehicle_image)","driver_lat":"\(nearestDriverController.DriverCsTATUS!.driver_lat)","driver_lng":"\(nearestDriverController.DriverCsTATUS!.driver_lng)","pickup_lat":"\(nearestDriverController.DriverCsTATUS!.pickup_lat)","pickup_lng":"\(nearestDriverController.DriverCsTATUS!.pickup_lng)"
,"dropoff_lat":"\(nearestDriverController.DriverCsTATUS!.dropoff_lat)","dropoff_lng":"\(nearestDriverController.DriverCsTATUS!.dropoff_lng)","pickup":"\(nearestDriverController.DriverCsTATUS!.pickup)","dropoff":"\(nearestDriverController.DriverCsTATUS!.dropoff)"]
            
            UserDefaults.standard.set(dict, forKey: "State")
            
        }else if(type == "remove"){
          
            let dict:[String:String] = ["jobid":"" , "status":"" ,"driver_id":"" ,"driver_name":"" ,"driver_contact":"" ,"driver_image":"" ,"driver_rating":"" ,"vehicle_id":"" ,"vehicle_name":""  ,"vehicle_model":"", "vehicle_plate":"","vehicle_image":"","driver_lat":"","driver_lng":"","dropoff_lng":"","dropoff_lat":"","pickup_lng":"","pickup_lat":"","pickup":"","dropoff":""]
            
            UserDefaults.standard.set(dict, forKey: "State")
            
            
        }
        
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return UIStatusBarStyle.lightContent
    }
    
    

    
  
    
    
}

