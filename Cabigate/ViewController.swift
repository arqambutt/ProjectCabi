//
//  ViewController.swift
//  Cabigate
//
//  Created by abdur rehman on 5/27/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GoogleMaps
import GooglePlaces
import SDWebImage

class ViewController: UIViewController ,MKMapViewDelegate, CLLocationManagerDelegate, GMSMapViewDelegate   {
    
    static var instance  = ViewController()
    static var object :ViewController {
        return instance
    }
    
    
    //Display Main attributes
    /////////////////////////////////////
    @IBOutlet weak var destinationCityName: UILabel!
    @IBOutlet weak var destinationCityCity: UILabel!
    
    @IBOutlet weak var myLocationLabel: UILabel!
    @IBOutlet weak var myLocationCity: UILabel!
  
    /////////////////////////////////
    
    
    @IBOutlet weak var exitButton: UIImageView!

    @IBOutlet weak var flipMenuButton: UIImageView!
   
    @IBOutlet weak var flipMenuBack: UIImageView!
    
    @IBOutlet weak var CollectionViewOne: UICollectionView!
    @IBOutlet weak var TableViewOne: UITableView!
    
    @IBOutlet weak var SideBarProfilePic: UIImageView!
    @IBOutlet weak var SlidebackView: UIView!
  
    
    @IBOutlet weak var BelowView: UIView!
    
    @IBOutlet weak var flipViewMain: UIView!
    
    @IBOutlet weak var clickMyLocation: UIImageView!
    
    @IBOutlet weak var CoustomMapView: GMSMapView!
    
    @IBOutlet weak var EnterDestinationView: UIView!

    @IBOutlet weak var FareView: UIView!
    
    @IBOutlet weak var SampleImge: UIImageView!
    
    @IBOutlet weak var LeadingContraints: NSLayoutConstraint!
    
    @IBOutlet weak var BackStatusView: UIView!
    
    @IBOutlet weak var PaymentMethod: UIView!
    
    @IBOutlet weak var FareEstimate: UIView!
    
    
    @IBOutlet weak var RequestRide: UIView!
    
    
    
    @IBOutlet weak var payments: UILabel!
    
    
    @IBOutlet weak var history: UILabel!
    
    @IBOutlet weak var settings: UILabel!
    
    
    @IBOutlet weak var paymentsLabel: UILabel!
    
    // below view
    
    @IBOutlet weak var confermToThisRide: UILabel!
    
    @IBOutlet weak var taxiType: UILabel!
    
    @IBOutlet weak var EtaTime: UILabel!
    
    @IBOutlet weak var Luggage: UILabel!
    
    @IBOutlet weak var MaxPeople: UILabel!
   
    @IBOutlet weak var Color: UILabel!


    
    
    

    var InitailLat:Double = 0.0
    var DestiLat:Double = 0.0
    
     let Manager = CLLocationManager()
    
     var Cheak = false
    
     var placee:GMSPlace?
    
    var SetorDestination = ""
    
    var destinationLongitude:Double = 0.0
    var DestinationLatitude:Double = 0.0
    var ChosserCar = "mpv"
    
    var carImgList = ["default", "sedan", "station_wagon", "compact","executive", "mpv" , "minibus" ]
    var carNameList = ["Default","Sedan", "Wagon", "Compact","Executive",  "MPV", "Minibus"]
    
  var tArray = [logitude]()
   
    func sayHello()
    {
       
        
        if (placee == nil){
            
        }else {
          
            //makePolyLine()
        }
      
        nearestDriverController.object.nearestDriver { (results) in
            
            if results == true {
                
             print("Cars Has Been Initalized")
               
        
                self.coustomCarLoad(carName: self.ChosserCar)
              
            }
            
        }
        
        
    }
   
    
    func verifySignin(){
        
        
        
        let temp =  UserDefaults.standard.value(forKey: "token")!
        
        
        if(temp as! String == ""){
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "llll")
            present(controller, animated: true, completion: nil)
            
            
        }
        else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "llll")
            present(controller, animated: true, completion: nil)
            
        }
        
        print( UserDefaults.standard.value(forKey: "token")!)
        print(UserDefaults.standard.value(forKey: "UID")!)
        print(UserDefaults.standard.value(forKey: "fname")!)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
        PaymentMethod.layer.cornerRadius = PaymentMethod.frame.width/2
        PaymentMethod.clipsToBounds = true
        PaymentMethod.layer.borderColor = UIColor.black.cgColor
        PaymentMethod.layer.borderWidth.add(0.5)
        PaymentMethod.backgroundColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1)
        
        FareEstimate.layer.cornerRadius = FareEstimate.frame.width/2
        FareEstimate.clipsToBounds = true
        FareEstimate.layer.borderColor = UIColor.black.cgColor
        FareEstimate.layer.borderWidth.add(0.5)
        FareEstimate.backgroundColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1)
        
        
        
        RequestRide.layer.cornerRadius = RequestRide.frame.width/2
        RequestRide.clipsToBounds = true
        RequestRide.layer.borderColor = UIColor.black.cgColor
        RequestRide.layer.borderWidth.add(0.5)
        RequestRide.backgroundColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1)
        
        BackStatusView.alpha = 0.8
        BackStatusView.layer.shadowColor = UIColor.white.cgColor
        BackStatusView.layer.shadowOpacity = 1
        BackStatusView.layer.shadowOffset = CGSize.init(width: 0, height: 50)
        BackStatusView.layer.shadowRadius = 20
        
        
        
        
        
        
        
        flipViewMain.layer.shadowColor = UIColor.lightGray.cgColor
        flipViewMain.layer.shadowOpacity = 0.2
        flipViewMain.layer.shadowOffset = CGSize.zero
        flipViewMain.layer.shadowRadius = 5
        
        CollectionViewOne.frame.origin.y = self.view.frame.size.height
        BelowView.frame.origin.y = self.view.frame.size.height
        
        BelowView.layer.cornerRadius = BelowView.frame.width / 16
        
        BelowView.layer.shadowColor = UIColor.darkGray.cgColor
        BelowView.layer.shadowOpacity = 1
        BelowView.layer.shadowOffset = CGSize.zero
        BelowView.layer.shadowRadius = 40
        
        
        Manager.delegate = self
        Manager.desiredAccuracy = kCLLocationAccuracyBest
        Manager.requestWhenInUseAuthorization()
        Manager.startUpdatingLocation()
        
        
        
        
        LeadingContraints.constant = 0
        
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(ViewController.SetMyLocation))
        SampleImge.addGestureRecognizer(tap)
        SampleImge.isUserInteractionEnabled = true
        
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(ViewController.SetDestinationLocation))
        
        EnterDestinationView.addGestureRecognizer(tapTwo)
        EnterDestinationView.isUserInteractionEnabled = true
        
        let tapThree = UITapGestureRecognizer(target: self, action:#selector(ViewController.FareEstimateFun))
        FareEstimate.addGestureRecognizer(tapThree)
        FareEstimate.isUserInteractionEnabled = true
        
        
        let tapFive = UITapGestureRecognizer(target: self, action:#selector(ViewController.flipMenu))
        flipMenuButton.addGestureRecognizer(tapFive)
        flipMenuButton.isUserInteractionEnabled = true
        
        
        let tapsix = UITapGestureRecognizer(target: self, action:#selector(ViewController.flibBackMenu))
        flipMenuBack.addGestureRecognizer(tapsix)
        flipMenuBack.isUserInteractionEnabled = true
        
        let set = UITapGestureRecognizer(target: self, action:#selector(ViewController.OpenSettingPage))
        settings.addGestureRecognizer(set)
        settings.isUserInteractionEnabled = true
        
        
        let clickMyLocationTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.clickMyLocationFunction))
        clickMyLocation.addGestureRecognizer(clickMyLocationTap)
        clickMyLocation.isUserInteractionEnabled = true
        
        
        let historytap = UITapGestureRecognizer(target: self, action: #selector(ViewController.jumpTohistory))
        history.addGestureRecognizer(historytap)
        history.isUserInteractionEnabled = true
        
        let confermToThisRideTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.confermToThisRideTapFunc))
        confermToThisRide.addGestureRecognizer(confermToThisRideTap)
        confermToThisRide.isUserInteractionEnabled = true
        
        let paymentsLabelTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.paymentsLabelTapFun))
        paymentsLabel.addGestureRecognizer(paymentsLabelTap)
        paymentsLabel.isUserInteractionEnabled = true
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        confermToThisRide.layer.cornerRadius = SideBarProfilePic.frame.size.width / 14
        confermToThisRide.clipsToBounds = true
        SideBarProfilePic.layer.cornerRadius = SideBarProfilePic.frame.size.width / 2
        SideBarProfilePic.clipsToBounds = true
        
        SlidebackView.layer.cornerRadius = SlidebackView.frame.size.width / 2
        SlidebackView.clipsToBounds = true

        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
        
        nearestDriverController.object.SocketRequest()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let result = formatter.string(from: date)
       
        print(result)
        downloadImg.object.DownloadImg(imgName: "") { (result) in
            
            if(result == ""){
                
                print("yes a gye ha")
            }
            else {
                print("nahi aii")
            }
        }
        
        
       // verifySignin()
        

downloadImg.object.DownloadImg(imgName: "https://paxapi.cabigate.com/theme/admin/img/vehicles/mapicons/mpv.png") { (result) in
    
    if(result == ""){
        
        print("a gye ha")
        
    }else {
        print("nahi aye")
    }
    
        }
     
        clickMyLocationFunction()
        
        
        Timer.scheduledTimer(timeInterval: 5 , target: self, selector: #selector(sayHello), userInfo: nil, repeats: true)
        
       
      
    }
    
    func paymentsLabelTapFun(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "scanCard")
        present(controller, animated: true, completion: nil)
        
        
    }
    func confermToThisRideTapFunc() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Driver")
        present(controller, animated: true, completion: nil)
        
    }
    
    
    func jumpTohistory(){
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "History")
        present(controller, animated: true, completion: nil)
    }
    
    
    func OpenSettingPage(){
    
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "setting")
        present(controller, animated: true, completion: nil)
        
    }
    
    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
           
            
            UIView.animate(withDuration: 0.2, delay: 0.2, options: [  .transitionFlipFromBottom], animations: {
                
            
            self.LeadingContraints.constant = 320
            self.CollectionViewOne.frame.origin.y = self.view.frame.size.height
            self.BelowView.frame.origin.y = self.view.frame.size.height
                    
           }, completion: nil)

            
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            
            
            
            UIView.animate(withDuration: 0.2, delay: 0.2, options: [  .transitionFlipFromLeft], animations: {
                
                self.LeadingContraints.constant = 0
                self.CollectionViewOne.frame.origin.y = self.view.frame.size.height
                self.BelowView.frame.origin.y = self.view.frame.size.height
               
            }, completion: nil)
        
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            
            UIView.animate(withDuration: 0.2, delay: 0.2, options: [  .transitionFlipFromBottom], animations: {
                
                self.CollectionViewOne.frame.origin.y = 15
                
                self.BelowView.frame.origin.y = 298
              
                self.FareView.frame.origin.y = 114
                
            }, completion: nil)
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
           
            
            
                
        UIView.animate(withDuration: 0.2, delay: 0.2, options: [ .transitionCurlDown], animations: {
            
            self.CollectionViewOne.frame.origin.y = self.view.frame.size.height
            self.BelowView.frame.origin.y = self.view.frame.size.height
        
                
                    
                  }, completion: nil)
        
        }
    }
    
    func flipMenu()
    {
       
            
            self.LeadingContraints.constant = 320
     
            
        
       
    }
    
    
    func flibBackMenu(){
        
        
            
        self.LeadingContraints.constant = 0
  
           
        
    }
    
    
    func FareEstimateFun() {
    
        if(InitailLat != 0.0 ){
            
            if(DestiLat != 0.0){
                
                
                        UIView.animate(withDuration: 0.2, delay: 0.2, options: [  .transitionFlipFromBottom], animations: {
                
                            self.CollectionViewOne.frame.origin.y = 40.5
                            self.BelowView.frame.origin.y = 355
                            self.FareView.frame.origin.y = 168
                            
                        }, completion: nil)
                
            }else {
                
                let controller = alert.object.alertForSignin(title: "Destination Location is Not selected", message: "Please make sure Destination Location is Selected")
                
                
                present(controller, animated: true, completion: nil)
                
            }
            

            
        }else{
            
       let controller = alert.object.alertForSignin(title: "Current Location is Not selected", message: "Please make sure Current Location is Selected")
            
            
        present(controller, animated: true, completion: nil)
        }
        
        
    }
    
    func FareEstimateClose() {
        
        CollectionViewOne.frame.origin.y = self.view.frame.size.height
        BelowView.frame.origin.y = self.view.frame.size.height
        exitButton.frame.origin.y = self.view.frame.size.height
    }
    
 
    var defaultMarker:GMSMarker?
    var InitialBestLocation:CLLocationCoordinate2D?
    
    
    /// main program
    func removePreviosMarker(){

        if(defaultMarker != nil){

              defaultMarker?.map = nil
            defaultMarker = nil
        }
        
    }

    func coustomLocationFunction(lat:Double , lon:Double , name:String){
    
        removePreviosMarker()

        let fancy = GMSCameraPosition.camera(withLatitude: lat,
                                             longitude:lon ,
                                             zoom: 14)
        
        self.CoustomMapView.camera = fancy
        self.CoustomMapView.animate(toLocation: CLLocationCoordinate2D(latitude: lat, longitude: lon))
        self.CoustomMapView.delegate = self
        self.CoustomMapView.isMyLocationEnabled = true
        self.CoustomMapView.settings.zoomGestures = true
       
        let position = CLLocationCoordinate2D(latitude: lat, longitude:lon)
        let marker = GMSMarker(position: position)
        marker.icon = GMSMarker.markerImage(with: UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1))
        defaultMarker  = marker
        marker.title = name
        InitialBestLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    
        marker.map = CoustomMapView
    }
    
    func getPlacemarkFromLocation(location: CLLocation){
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (error != nil) {
                    
                    print("reverse geodcode fail: \(String(describing: error?.localizedDescription))"
                    
                    
                    )}
                let pm = placemarks!
                if pm.count > 0 {
               
                 
                    
                    self.destinationCityName.text = pm[0].name
                    self.destinationCityCity.text = pm[0].country
                  
                    
                }
        })
    }
    func clickMyLocationFunction(){
        
         removePreviosMarker()
        
        let currentCordinate = Manager.location?.coordinate
        
     
        
        if CLLocationManager.locationServicesEnabled() {
            Manager.startUpdatingLocation()
            
        }
        
        if (currentCordinate?.longitude != nil){
            
            let location = CLLocation(latitude: (currentCordinate?.latitude)!, longitude: (currentCordinate?.longitude)!)
            InitailLat = (currentCordinate?.longitude)!
           
        let fancy = GMSCameraPosition.camera(withLatitude: currentCordinate!.latitude,
                                                 longitude:currentCordinate!.longitude ,
                                                 zoom: 14)
            
            
            getPlacemarkFromLocation(location: location)
            
            self.CoustomMapView.camera = fancy
            self.CoustomMapView.animate(toLocation: CLLocationCoordinate2D(latitude: currentCordinate!.latitude, longitude: currentCordinate!.longitude))
            self.CoustomMapView.delegate = self
            self.CoustomMapView.isMyLocationEnabled = true
            self.CoustomMapView.settings.zoomGestures = true
            
            let position = CLLocationCoordinate2D(latitude: currentCordinate!.latitude, longitude:currentCordinate!.longitude)
            let marker = GMSMarker(position: position)
            marker.icon = GMSMarker.markerImage(with: UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1))
            defaultMarker  = marker
             InitialBestLocation = CLLocationCoordinate2D(latitude: currentCordinate!.latitude, longitude: currentCordinate!.longitude)
            
         marker.tracksInfoWindowChanges = true
            
   
            
            marker.map = CoustomMapView
            
             CoustomMapView.selectedMarker = marker
        }
    
    }
    

    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
         let infoWindow = Bundle.main.loadNibNamed("CoustomViewForMap", owner: self.view, options: nil)!.first!
        as! infoPinView
       infoWindow.estimateTime.text = "\(String(describing: NearestObject?.eta_time))"
        
        return infoWindow
        
    }
    
    ///////// Rotation
    
    
    
    
    func getHeadingForDirection(fromCoordinate fromLoc: CLLocationCoordinate2D, toCoordinate toLoc: CLLocationCoordinate2D) -> Float {
        
        let fLat: Float = Float((fromLoc.latitude).degreesToRadians)
        let fLng: Float = Float((fromLoc.longitude).degreesToRadians)
        let tLat: Float = Float((toLoc.latitude).degreesToRadians)
        let tLng: Float = Float((toLoc.longitude).degreesToRadians)
        let degree: Float = (atan2(sin(tLng - fLng) * cos(tLat), cos(fLat) * sin(tLat) - sin(fLat) * cos(tLat) * cos(tLng - fLng))).radiansToDegrees
        if degree >= 0 {
            
            return degree
        }
        else {
            return 360 + degree
        }
    }
    
    
    var OldCarLocations = [GMSMarker]()
    
    var OldRotateLocations = [CLLocationCoordinate2D]()
 
    
    func removeOldMarker() {
        
        if(OldCarLocations.count != 0){
            
        for (i,_) in OldCarLocations.enumerated() {
       
            OldCarLocations[i].map = nil
            
        }
        }
        
    }
    
    func RotateMarker(marker:GMSMarker){
        
        
    }
    
    var executive = 1000
    var NearestObject:NDCLASS?
    var imgg = UIImage()
    var url:String = ""
    var carLists = [NDCLASS]()
    var tempArray = [String]()
    
    
//    func settinGvALUES() {
//        
//        
//         for (_,j) in nearestDriverController.ANearestDriver.enumerated(){
//        
//            tempArray.append(j.taxi_type)
//  
//        }
//        
//        
//        if tempArray.contains("sedan"){
//            
////            let object =  NDCLASS.init(driver_id: j.driver_id, taxi_model: j.taxi_model, driver_name: j.driver_name, phone: j.phone, taxi_color: j.taxi_color, taxi_type: j.taxi_type, eta_time: j.eta_time, MarkerPic: j.MarkerPic)
////            
////            
////            
////            
////            carLists.append(object)
//            
//        }
//        
//    
//        
//        
//    }
    
    
    func coustomCarLoad(carName:String) {
        
       removeOldMarker()
       OldCarLocations.removeAll()
        carLists.removeAll()
    
       
        
        
            for (i,j) in nearestDriverController.ANearestDriver.enumerated(){
            
             
          carLists.append(j)
                
            let position = CLLocationCoordinate2D(latitude: j.lat, longitude: j.lon)
                
                let marker = GMSMarker(position: position)
                
                marker.position = position
                
                marker.isFlat = true
                marker.tracksViewChanges = true
                marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            
              
             
                
                switch  nearestDriverController.ANearestDriver[i].taxi_type{
               
          
                    
                    
                case "\(carName)":
 
     
                    
                    taxiType.text = j.taxi_type
                    EtaTime.text = "\(j.eta_time)"
                    
                    
                   
                    Luggage.text = "7KG"
                    MaxPeople.text = "4"
                    Color.text = j.taxi_color
                    
                    
                    
                    if (url == ""){
                        
                        let imgurl:NSURL? = NSURL(string: "\(j.MarkerPic)")!
                        
                        url = "\(j.MarkerPic)"
                        
                        
                        let manager:SDWebImageManager = SDWebImageManager.shared()
                        manager.imageDownloader?.downloadImage(with: imgurl! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
                            
                            
                            // setting value
                            marker.icon = self.scaleImageToSize(img: IMG!, size: CGSize(width: 40.0, height: 40.0))
                            self.imgg = IMG!
                            //  marker.tracksInfoWindowChanges = true
                            marker.map = self.CoustomMapView
                            
                             })
                        
                        
                    }else if(url == j.MarkerPic){
                        
                      
                        // setting value
                        marker.icon = self.scaleImageToSize(img: imgg, size: CGSize(width: 40.0, height: 40.0))                        //  marker.tracksInfoWindowChanges = true
                        marker.map = self.CoustomMapView
                        
                    }else if (url != j.MarkerPic) {
                        
                        let imgurl:NSURL? = NSURL(string: "\(j.MarkerPic)")!
                        
                        url = "\(j.MarkerPic)"
                        
                        
                        let manager:SDWebImageManager = SDWebImageManager.shared()
                        manager.imageDownloader?.downloadImage(with: imgurl! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
                            
                            
                            // setting value
                            marker.icon = self.scaleImageToSize(img: IMG!, size: CGSize(width: 40.0, height: 40.0))
                            
                            
                            self.imgg = IMG!
                            //  marker.tracksInfoWindowChanges = true
                            marker.map = self.CoustomMapView
                            
                        })
                        
                        
                        
                    }else {
                        
                        
                       let imgurl:NSURL? = NSURL(string: "\(j.MarkerPic)")!
                        
                        url = "\(j.MarkerPic)"
                        
                        
                        let manager:SDWebImageManager = SDWebImageManager.shared()
                        manager.imageDownloader?.downloadImage(with: imgurl! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
                            
                            
                            // setting value
                            marker.icon = self.scaleImageToSize(img: IMG!, size: CGSize(width: 40.0, height: 40.0))
                            self.imgg = IMG!
                            //  marker.tracksInfoWindowChanges = true
                            marker.map = self.CoustomMapView
                            
                        })
                        
                    }
           
            
                        
                        
                   
     
                    OldCarLocations.append(marker)
                    OldRotateLocations.append(position)
                    CollectionViewOne.reloadData()

                    break
                   default:
                    break
                }

               
                
                
                }
    
       
        nearestDriverController.ANearestDriver.removeAll()
   
   
    }
    
    

       
    func OpenMenu() {
    
        
        
        let downwards = GMSCameraUpdate.scrollBy(x: 50, y: 150)
        self.CoustomMapView.animate(with: downwards)
      
    }
    
 

    func scaleImageToSize(img: UIImage, size: CGSize) -> UIImage {
        
                UIGraphicsBeginImageContext(size)
                img.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
                let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return scaledImage!
  
            }
        

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    
    var OldPMarker:GMSMarker? = nil
    var OldPPolyline:GMSPolyline? = nil
    var previousIndex:IndexPath? = nil
    
}

extension ViewController :GMSAutocompleteViewControllerDelegate {
    
    
    
    func SetDestinationLocation() {
        SetorDestination = "Destination"
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
    
    
    func SetMyLocation() {
        
        SetorDestination = "Set"
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
      
        
        
        if ( SetorDestination == "Set"){
            
           
            
        coustomLocationFunction(lat: place.coordinate.latitude, lon: place.coordinate.longitude, name: place.name)

        }else if ( SetorDestination == "Destination"){
            
            placee = place
            makePolyLine(placess: place)
            
            myLocationLabel.text = place.name
        

            
            
        }
      
        dismiss(animated: true, completion: nil)
       
        
    }
    
   ///////////////////////////// PolyLines
    
    func RemoveOldPoliLine(){
        
        if(OldPMarker != nil){
            
            OldPMarker?.map = nil
            OldPMarker = nil
        }
        
        if(OldPPolyline != nil){
            
            OldPPolyline?.map = nil
            OldPPolyline = nil
        }


        
    }
    
    func makePolyLine(placess:GMSPlace) {
        
     RemoveOldPoliLine()
        
     
        let destinationCordinate = CLLocationCoordinate2DMake(placee!.coordinate.latitude, placee!.coordinate.longitude)
        
        let destination = "\(destinationCordinate.latitude),\(destinationCordinate.longitude)"
       DestiLat = destinationCordinate.latitude
        
        let origin = "\(String(describing: InitialBestLocation!.latitude)),\(String(describing:  InitialBestLocation!.longitude))"

        
        let todoEndpoint: String = "https://maps.googleapis.com/maps/api/directions/json?origin=\( origin)&destination=\(destination)&key=AIzaSyB6D54NhJotKJplTKlzE8RZDlImJY1hmtY"
        
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        DispatchQueue.global(qos: .background).async {
            
            // make the request
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                // do stuff with response, data & error here
                
                
                do {
                    
                    let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            
                     DispatchQueue.main.async {
                    let yes = temp["routes"] as! NSArray
                    
                    let polyline = yes.value(forKey: "overview_polyline") as! NSArray
                    
                         let point = polyline.value(forKey: "points") as! NSArray
                            
                      
                        if(point.count != 0){
                            
                        let path = GMSPath.init(fromEncodedPath: point[0] as! String)
                            
                            let polylinetwo = GMSPolyline.init(path: path)
                            
                            polylinetwo.strokeWidth = 4
                            polylinetwo.strokeColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1)
                            self.OldPPolyline = polylinetwo
                            polylinetwo.map = self.CoustomMapView
                            
                            let position = CLLocationCoordinate2D(latitude: placess.coordinate.latitude, longitude:placess.coordinate.longitude)
                            let marker = GMSMarker(position: position)
                            marker.icon = GMSMarker.markerImage(with: .black)
                            marker.title = placess.name
                            self.OldPMarker = marker
                            marker.map = self.CoustomMapView
                            
                        }
                        else{
                            
                            let controller = alert.object.alertForSignin(title: "Alert!", message: "Make sure you have Chosen Right Path!")
                            
                            self.present(controller, animated: true, completion: nil)
                        }
                        
                    }
                
                } catch {
                    print(error)
                }
                
            })
            
            task.resume()
        }
           }
    
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    }


extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

extension ViewController:UICollectionViewDataSource , UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carLists.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
      
            let cellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath) as! flipMenuCell
        
//        var carImgList = ["default", "sedan", "station_wagon", "compact","executive", "mpv" , "minibus" ]
//        var carNameList = ["Default","Sedan", "Wagon", "Compact","Executive",  "MPV", "Minibus"]
        
        
      cellTwo.layer.cornerRadius = cellTwo.frame.width / 2
      cellTwo.clipsToBounds = true
     
        cellTwo.configrationOfCell(name:carLists[indexPath.row].taxi_type , ImgURL: carLists[indexPath.row].MarkerPic )
        
        
        
        return cellTwo
        
    }
 
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
       
            ChosserCar = carLists[indexPath.row].taxi_type
            coustomCarLoad(carName: ChosserCar)
        
   
  
    }
    
    
}



extension ViewController:UITableViewDataSource, UITableViewDelegate {
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carImgList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellTwo", for: indexPath)
        
      
        cell.backgroundView?.alpha = 0.5
        cell.textLabel?.text = "hellow"

        return cell
    }
    
    
}
