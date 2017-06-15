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

class ViewController: UIViewController ,MKMapViewDelegate, CLLocationManagerDelegate, GMSMapViewDelegate   {
    
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
    
    
    
    
   
    struct StructDestination{
        
        var lat:Double = 0.0
        var lon:Double = 0.0
    
        var DesLocationName:String = ""
        
    }
    var Destination = [StructDestination]()

    var tempLat:Double = 0.0
    
    
     let Manager = CLLocationManager()
    
     var Cheak = false
    
     var placee:GMSPlace?
    
    var SetorDestination = ""
    
    var destinationLongitude:Double = 0.0
    var DestinationLatitude:Double = 0.0
    
    
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
               
          
                
              
            }
            
        }
        
        
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        print( UserDefaults.standard.value(forKey: "token")!)
//        print(UserDefaults.standard.value(forKey: "UID")!)
//        print(UserDefaults.standard.value(forKey: "fname")!)
        
  // nearestDriverController.object.SocketRequest()
   
     self.InitalizeCars()

     
        clickMyLocationFunction()
        
        
        Timer.scheduledTimer(timeInterval: 5 , target: self, selector: #selector(sayHello), userInfo: nil, repeats: true)
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
        
        
        
        
        FareView.layer.shadowColor = UIColor.black.cgColor
        FareView.layer.shadowOpacity = 0.7
        FareView.layer.shadowOffset = CGSize.zero
        FareView.layer.shadowRadius = 5
        
        
        
        flipViewMain.layer.shadowColor = UIColor.black.cgColor
        flipViewMain.layer.shadowOpacity = 0.8
        flipViewMain.layer.shadowOffset = CGSize.zero
        flipViewMain.layer.shadowRadius = 5
     
        CollectionViewOne.frame.origin.y = self.view.frame.size.height
        BelowView.frame.origin.y = self.view.frame.size.height
        
        BelowView.layer.cornerRadius = BelowView.frame.width / 12
        BelowView.clipsToBounds = true
        BelowView.layer.shadowColor = UIColor.black.cgColor
        BelowView.layer.shadowOpacity = 1
        BelowView.layer.shadowOffset = CGSize.zero
        BelowView.layer.shadowRadius = 10
       // BelowView.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath

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
        
        
        SideBarProfilePic.layer.cornerRadius = SideBarProfilePic.frame.size.width / 2
        SideBarProfilePic.clipsToBounds = true
        
        SlidebackView.layer.cornerRadius = SlidebackView.frame.size.width / 2
        SlidebackView.clipsToBounds = true
        
       
      
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
           
           UIView.animate(withDuration: 0.3, animations: {
            
            self.LeadingContraints.constant = 320
            self.CollectionViewOne.frame.origin.y = self.view.frame.size.height
            self.BelowView.frame.origin.y = self.view.frame.size.height
                    
           })
                
                
            
                
           
            
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            
            
//            UIView.animate(withDuration: 5.5, delay: 5.5, options: [.transitionFlipFromLeft], animations: {
//                
//                self.LeadingContraints.constant = 0
//                self.CollectionViewOne.frame.origin.y = self.view.frame.size.height
//                self.BelowView.frame.origin.y = self.view.frame.size.height
//               
//            }, completion: nil)

        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            
            UIView.animate(withDuration: 0.2, delay: 0.2, options: [  .transitionFlipFromBottom], animations: {
                
                self.CollectionViewOne.frame.origin.y = 65
                
                self.BelowView.frame.origin.y = 298
              
                self.FareView.frame.origin.y = 187
                
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
    
        if(tempLat != 0.0 ){
            
            if(Destination[0].lat != 0.0){
                
                
                        UIView.animate(withDuration: 0.2, delay: 0.2, options: [  .transitionFlipFromBottom], animations: {
                
                            self.CollectionViewOne.frame.origin.y = 40.5
                            self.BelowView.frame.origin.y = 340
                            self.exitButton.frame.origin.y = 8
                            self.FareView.frame.origin.y = 158
                            
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
    
    
    func clickMyLocationFunction(){
        
         removePreviosMarker()
        
        let currentCordinate = Manager.location?.coordinate
        
        
        
        if CLLocationManager.locationServicesEnabled() {
            Manager.startUpdatingLocation()
            
        }
        
        if (currentCordinate?.longitude != nil){
            
            
            tempLat = (currentCordinate?.longitude)!
           
        let fancy = GMSCameraPosition.camera(withLatitude: currentCordinate!.latitude,
                                                 longitude:currentCordinate!.longitude ,
                                                 zoom: 14)
            
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
            marker.map = CoustomMapView
        }
    
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
    
    func DefaultCar() {
        
        removeOldMarker()
        OldCarLocations.removeAll()

        for (i,j) in nearestDriverController.ANearestDriver.enumerated(){
            
            
            let position = CLLocationCoordinate2D(latitude: j.lat, longitude: j.lon)
            
            let marker = GMSMarker(position: position)
            
            marker.position = position
            marker.isFlat = true
            marker.tracksViewChanges = true
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            
            
            switch  nearestDriverController.ANearestDriver[i].taxi_type{
            case "sedan":
      
                marker.map = CoustomMapView
                marker.tracksInfoWindowChanges = true
                marker.icon = scaleImageToSize(img:UIImage(named: "sedan")! , size: CGSize(width: 40, height: 40))
                break

            default:
                break
            }
            
            
            
            
            OldCarLocations.append(marker)
            OldRotateLocations.append(position)
            
            
        }
        
        
        nearestDriverController.ANearestDriver.removeAll()
        
        
    }
    
    func InitalizeCars() {
        
        removeOldMarker()
        OldCarLocations.removeAll()
 
        
            for (i,j) in nearestDriverController.ANearestDriver.enumerated(){
            
                
            let position = CLLocationCoordinate2D(latitude: j.lat, longitude: j.lon)
                
            
               
            let marker = GMSMarker(position: position)
         
                marker.position = position
                
                marker.isFlat = true
                marker.tracksViewChanges = true
                marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
              
             
                switch  nearestDriverController.ANearestDriver[i].taxi_type{
               
                case "mpv":

                    marker.icon = scaleImageToSize(img:UIImage(named: "mpv")! , size: CGSize(width: 40, height: 40))
                    
                    marker.map = CoustomMapView
                    marker.tracksInfoWindowChanges = true
                    break
               
                default:
                    break
                }

                OldCarLocations.append(marker)
                OldRotateLocations.append(position)
                
                
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
        return carImgList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
      
            let cellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath) as! flipMenuCell
        
        
      cellTwo.layer.cornerRadius = cellTwo.frame.width / 2
      cellTwo.clipsToBounds = true
        cellTwo.backgroundView?.backgroundColor = UIColor.blue
        
         cellTwo.configrationOfCell(name: carNameList[indexPath.item], Img: UIImage(named: "\(carImgList[indexPath.item])")!)
    
        cellTwo.BackGroungView.backgroundColor = UIColor.clear
        return cellTwo
        
    }
 
    
    
    
    
}



extension ViewController:UITableViewDataSource, UITableViewDelegate {
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellTwo", for: indexPath)
        
      
        cell.backgroundView?.alpha = 0.5
        cell.textLabel?.text = "hellow"

        return cell
    }
    
    
}
