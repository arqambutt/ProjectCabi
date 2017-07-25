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


class ViewController: UIViewController , CLLocationManagerDelegate, GMSMapViewDelegate , UITextFieldDelegate , UICollectionViewDelegateFlowLayout  {
    
    
    static var instance  = ViewController()
    static var object :ViewController {
        return instance
    }
    var cheakForPolyline = true
    @IBOutlet weak var pinToFecthLocation: UIImageView!
    @IBOutlet weak var rideNowBtn: UIButton!
    @IBOutlet weak var mainPicView: UIView!
    @IBOutlet weak var desTextField: UITextField!
    
    @IBOutlet weak var flagPic: UIImageView!
    @IBOutlet weak var desPic: UIImageView!
    
    @IBOutlet weak var picUpTextField: UITextField!
    
    
    @IBOutlet weak var belowviewMain: UIView!
    
    @IBOutlet weak var destinationOpenBtn: UIButton!
    @IBOutlet weak var selectSharedHome: UIButton!
    @IBOutlet weak var selectSharedWork: UIButton!
    
    @IBOutlet weak var addbuttonOneAnim: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var DesBtnOne: UIButton!
    @IBOutlet weak var desOpenTwo: UIButton!
    
    @IBOutlet weak var flipTable: UITableView!
    
    
    @IBOutlet weak var picUpindecator: UIActivityIndicatorView!
    
    @IBOutlet weak var desIndicator: UIActivityIndicatorView!
    

    
    @IBOutlet weak var flipMenuButton: UIImageView!
    
    @IBOutlet weak var flipMenuBack: UIImageView!
    
    @IBOutlet weak var CollectionViewOne: UICollectionView!
     @IBOutlet weak var CollectionViewTwo: UICollectionView!
    
    @IBOutlet weak var SideBarProfilePic: UIImageView!
    @IBOutlet weak var SlidebackView: UIView!
    
    @IBOutlet weak var BelowViewF: UIView!
    
    
    
    @IBOutlet weak var flipViewMain: UIView!
    
    
    @IBOutlet weak var CoustomMapView: GMSMapView!
    
    
    
    
    @IBOutlet weak var LeadingContraints: NSLayoutConstraint!
    
    @IBOutlet weak var ProfileName: UILabel!
    
    @IBOutlet weak var PicUpLocationLabel: UILabel!
   
   


    
    
    @IBOutlet weak var clickMyLocationBtn: UIButton!
    
    @IBAction func clickMyLocation(_ sender: Any) {
        
           clickMyLocationFunction()
        
    }
    
    var desRotate = false
    var rotate = false

    
    
    let Manager = CLLocationManager()
    
    var Cheak = false
    
    
    
    var SetorDestination = ""
    

    // BelowViewF
    
    @IBOutlet weak var rideLater: UIButton!
    @IBOutlet weak var taxiType: UILabel!
    @IBOutlet weak var EtaTime: UILabel!
    @IBOutlet weak var Luggage: UILabel!
    @IBOutlet weak var MaxPeople: UILabel!
    @IBOutlet weak var showFare: UILabel!
    @IBOutlet weak var RequestRideAction: UIButton!
    
    @IBOutlet weak var border4: UIView!
    @IBOutlet weak var border3: UIView!
    @IBOutlet weak var border2: UIView!
    @IBOutlet weak var border1: UIView!
    @IBOutlet weak var border: UIView!
    
    
    
    
    let Options = ["PAYMENTS", "HISTORY","FREE RIDES", "PROMOTIONS", "SETTINGS", "LOGOUT" , "CONTECT US"]
    let white = ["ccw", "pubw" ,"traw", "prow", "sw", "sw" , "CUSW"]
    
    let black = ["cc", "pub","tra", "pro", "s", "s" , "CUSB"]
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("Memory warning remove")
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
        
        viewHelper.instance.border_Function(views: border, colorName: "white")
        viewHelper.instance.border_Function(views: border1, colorName: "white")
        viewHelper.instance.border_Function(views: border2, colorName: "white")
        viewHelper.instance.border_Function(views: border3, colorName: "white")
        viewHelper.instance.border_Function(views: border4, colorName: "white")
        viewHelper.instance.border_Function(views: RequestRideAction, colorName: "blue")
        
        
        fetchHistory()
        CoustomMapView.delegate = self
        flipViewMain.isUserInteractionEnabled = true
        flipViewMain.clipsToBounds = true
        flipTable.isUserInteractionEnabled = true
        

        rideLater.layer.borderWidth = 1
        rideLater.layer.borderColor = UIColor.white.cgColor
        
       
        flipTable.separatorStyle = UITableViewCellSeparatorStyle.none
        
        CoustomMapView.delegate = self
        self.view.addSubview(flipViewMain)
      
        
        flipMenuBack.isHidden = true
        Manager.delegate = self
        Manager.desiredAccuracy = kCLLocationAccuracyBest
        Manager.requestWhenInUseAuthorization()
        Manager.startUpdatingLocation()
        
        if(ImportHistory.historyArray.count > 0){
             CollectionViewTwo.reloadData()
                   }
       
        CoustomMapView.addSubview(flipViewMain)
        belowviewMain.isHidden = true
        LeadingContraints.constant = 0
        
        picUpindecator.isHidden = true
        desIndicator.isHidden = true
        self.flipMenuButton.isHidden = false
        mainPicView.isHidden = false
       
        
        let tapFive = UITapGestureRecognizer(target: self, action:#selector(ViewController.flipMenu))
        flipMenuButton.addGestureRecognizer(tapFive)
        flipMenuButton.isUserInteractionEnabled = true
        
        
        let tapsix = UITapGestureRecognizer(target: self, action:#selector(ViewController.flibBackMenu))
        flipMenuBack.addGestureRecognizer(tapsix)
        flipMenuBack.isUserInteractionEnabled = true
       
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        SideBarProfilePic.layer.cornerRadius = SideBarProfilePic.frame.size.width / 2
        SideBarProfilePic.clipsToBounds = false
      

        SlidebackView.layer.cornerRadius = SlidebackView.frame.size.width / 2
        SlidebackView.clipsToBounds = true
        
        pinToFecthLocation.isHidden = true

        
        
    }
    
    
    func CheakifPolylineAlreadyExist(){
        
        if(booking.object.dropUpLat != "" && booking.object.picUpLat != ""){
            
            makePolyLine()
            
            
    
            desTextField.text = "\(booking.object.DeslocName)"
            picUpTextField.text = "\(booking.object.currentlocName)"
            
            
            if(desTextField.text?.characters.count == 0){
                
                desPic.image = UIImage(named: "flag")
                
                
            }
            else{
                
                desPic.image = UIImage(named: "colorflag")
                
            }
            if(self.picUpTextField.text?.characters.count == 0){
                
                self.flagPic.image = UIImage(named: "location-2")
                
            }
            else{
                
                self.flagPic.image = UIImage(named: "colorlocation")
                
            }
            
            
            makeMarker(type: "pic")
            makeMarker(type: "des")
            makePolyLine()
            self.fareEstimateFunc(TaxiModal: "40")
            
             let positionq = CLLocationCoordinate2D(latitude: (Double(booking.object.picUpLat))!, longitude:(Double(booking.object.picUpLon))!)
            CoustomMapView.animate(toLocation:positionq )
            CoustomMapView.animate(toZoom: 16)
            
     
            
        }else {
                clickMyLocationFunction()
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
            
    
        CheakifPolylineAlreadyExist()
        
        
        waitingScreen.instance.SetValuetoShare(type: "remove")
        let centerX = self.view.center.x - 15
        let centeY = self.view.center.y
        pinToFecthLocation.isHidden = false
        pinToFecthLocation.frame = CGRect(x: centerX, y: centeY, width: 30, height: 30)
        
        buttonOne.alpha = 0
        buttonTwo.alpha = 0
       
        mainPicView.frame = CGRect(x: 0 , y: 80, width: self.view.frame.width-32, height: mainPicView.frame.height)
        
        mainPicView.center.x = self.view.center.x
        
        belowviewMain.frame = CGRect(x: 0, y: mainPicView.frame.height * 2, width: self.view.frame.width-32, height: belowviewMain.frame.height)
        
        belowviewMain.center.x = self.view.center.x
        
       clickMyLocationBtn.isHidden = false
        
        mainPicView.layer.shadowColor = UIColor(displayP3Red: 6/255, green: 191/255, blue: 195/255, alpha: 1).cgColor
        mainPicView.layer.shadowOpacity = 0.5
        mainPicView.layer.shadowOffset = CGSize.zero
        mainPicView.layer.shadowRadius = 1
        
        picUpTextField.delegate = self
        desTextField.delegate = self
        picUpTextField.endEditing(true)
        desTextField.endEditing(true)
        
       
        CoustomMapView.alpha = 0.8
        
      
        nearestDriverController.object.nearestDriver { (results) in
            
            if results == true {
                
           
                self.LoadSpecificCars()
                self.coustomCarLoad(taxiModal: "40")
                
            }
            
        }

        
     
        
        
        nearestDriverController.object.SocketRequest { (result) in
            
            if(result == ""){
                
                
                self.temp()
                
                
                
            }else if (result == "Driver"){
                
                if(nearestDriverController.DriverCsTATUS!.status == "connecting") {
                    
                }else {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "waiting")
                    
                    self.present(controller, animated: true, completion: nil)
                }
                
               
                
                
            }
        }

        
        
      
        if(userDetail.object.cheak == false) {
            
         
            fetchUserDetail.object.downloadUserDetail { (result) in
                
                
                if (result == ""){
                    
   
                    if(userDetail.object.fname != "" &&  userDetail.object.lName != ""){
                        
                       
                         self.ProfileName.text! = "\(userDetail.object.fname) \(userDetail.object.lName)"
                        
                        let imgurl:NSURL? = NSURL(string: "\(userDetail.object.profilePicUrl)")!
                        
                        
                        
                        let manager:SDWebImageManager = SDWebImageManager.shared()
                        manager.imageDownloader?.downloadImage(with: imgurl! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload , .useNSURLCache], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
                            

                            if let imgg = IMG {
                              
                             userDetail.object.orignalImg = imgg
                            self.SideBarProfilePic.image =  userDetail.object.orignalImg
                                
                            }
                            
                        })
                        if(self.picUpTextField.text != ""){
                            
                            self.PicUpLocationLabel.text = self.picUpTextField.text
                        }
                        userDetail.object.cheak = true
                    }
                }
                }
        
        }else {
            
            self.SideBarProfilePic.image = userDetail.object.orignalImg
            self.ProfileName.text! = "\(userDetail.object.fname) \(userDetail.object.lName)"
        }
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self.view)
             self.flipViewMain.frame.origin.x -= 10
            print(position.y)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
        
    }
        
  
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == desTextField){
            
            resignFirstResponder()
        }
        
        return false
    }
    
    func fetchHistory(){
    
   
        
    ImportHistory.object.FetchHistory { (result) in
    
    if(result == true){
  
    self.CollectionViewTwo.reloadData()
    
    
    }else{
        
    
    self.CollectionViewTwo.isHidden = true
    }
    }
    
    }
    

    
    func getCityNameAndCordinate(field:String){
        
        
        let centerX = self.CoustomMapView.center.x
        let centeY = self.CoustomMapView.center.y
        
        let point = CGPoint(x: centerX, y: centeY)
        
        
        let cordinate = CoustomMapView.projection.coordinate(for: point)
        
        
        let location = CLLocation(latitude: cordinate.latitude, longitude: cordinate.longitude)
        
        
        
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (error != nil) {
                    
                    print("reverse geodcode fail: \(String(describing: error?.localizedDescription))"
                        
                        
                    )}else  {
                let pm = placemarks!
                
                if pm.count > 0 {
                    
                
                    
                    if(field == "iniitaial"){
                        
                        self.picUpindecator.isHidden = true
                        self.picUpindecator.stopAnimating()
                        
                        booking.object.picUpLat = "\(location.coordinate.latitude)"
                        booking.object.picUpLon = "\(location.coordinate.longitude)"
                        self.picUpTextField.text = "\(pm[0].name!)"
                          booking.object.currentlocName = "\(pm[0].name!)"
                        self.makeMarker(type: "pic")
                        
                        if(self.picUpTextField.text?.characters.count == 0){
                            
                            self.flagPic.image = UIImage(named: "location-2")
                            
                        }
                        else{
                            
                            self.flagPic.image = UIImage(named: "colorlocation")
                            
                        }
                        
                        
                        if(booking.object.dropUpLat != "" && booking.object.picUpLat != ""){
                         
                             self.makePolyLine()
                        }
                        
                       
                        
                        
                    }else if (field == "Des"){
                        
                        
                        
                        self.desIndicator.isHidden = true
                        self.desIndicator.stopAnimating()
                        
                        
                        print(pm[0].name!)
                        
                        booking.object.dropUpLat = "\(location.coordinate.latitude)"
                        booking.object.dropUpLon = "\(location.coordinate.longitude)"
                        booking.object.DeslocName = "\(pm[0].name!)"
                        self.desTextField.text = "\(pm[0].name!)"
                        self.makeMarker(type: "des")
                        if(self.desTextField.text?.characters.count == 0){
                            
                            self.desPic.image = UIImage(named: "flag")
                            
                            
                        }
                        else{
                            
                            self.desPic.image = UIImage(named: "colorflag")
                            
                        }
                        
                        
                        if(booking.object.picUpLat != ""){
                            
                            self.makePolyLine()
                        }
                        
                        
                    }
                }
                }
        })
        
    }
    
    
    func fetchUserInfo(){
        
        
        let result = UserDefaults.standard.value(forKey: "fname")
        
        if(result != nil){
            
        
        if(String(describing: result!) != "" ){
            
             ProfileName.text = String(describing: result!)
        }
        if(booking.object.currentlocName != ""){
           
           
           PicUpLocationLabel.text =  "\(booking.object.currentlocName)"
        }
        }
        
    }
    /////////////////////////////////////// /////////////////////////shared Value System
    var pName = ""
    var plat = ""
    var plon = ""
    
    
    
    func getSharedValue(typeofValue:String , typeOfButton:String){
        
        if(typeofValue == "WORK" && typeOfButton == "picUpButton"){
            
          
            if(userDetail.object.work_address != ""){
                
                let cheak = GoodToGo()
                
                
                if(cheak == true){
                    
                    picUpTextField.text = userDetail.object.work_address
                    booking.object.currentlocName = userDetail.object.work_address
                    booking.object.picUpLat = userDetail.object.work_lat
                    booking.object.picUpLon = userDetail.object.work_lng
                    makeMarker(type: "pic")
                    
                }else {
                    
                    
                    
                }
                
               
                
            }else {
                
                //move to setting
            }
            
                if(booking.object.dropUpLat != ""){
                    
                    self.makePolyLine()
                }
           
            
        } else if(typeofValue == "HOME" && typeOfButton == "picUpButton"){
            
            if(userDetail.object.home_address != ""){
                
                let cheak = GoodToGo()
                
                
                if(cheak == true){
                    
                    picUpTextField.text = userDetail.object.home_address
                    booking.object.currentlocName = userDetail.object.home_address
                    booking.object.picUpLat = userDetail.object.home_lat
                    booking.object.picUpLon = userDetail.object.home_lng
                    makeMarker(type: "pic")
                    
                    
                }else {
                    
                    
                }
                
               
                
            }else {
                
                //setting
            }
            
            if(booking.object.dropUpLat != ""){
                
                self.makePolyLine()
            }
            
            
        }else if(typeofValue == "HOME" && typeOfButton == "DestButton"){
            
            if(userDetail.object.home_address != ""){
                
                let cheak =  GoodToGo()
                
                if(cheak == true){
                    
                    desTextField.text = userDetail.object.home_address
                    booking.object.DeslocName = userDetail.object.home_address
                    booking.object.dropUpLat = userDetail.object.home_lat
                    booking.object.dropUpLon = userDetail.object.home_lng
                    makeMarker(type: "des")
                    makePolyLine()
                    if(desTextField.text?.characters.count == 0){
                        
                        desPic.image = UIImage(named: "flag")
                        
                        
                    }
                    else{
                        
                        desPic.image = UIImage(named: "colorflag")
                        
                    }
                    
                }else{
                    
                    
                }
                
            }else {
                
                // go to setting
            }
            
      
            
        }else if(typeofValue == "WORK" && typeOfButton == "DestButton"){
            
            if(userDetail.object.work_address != ""){
                
                let cheak =  GoodToGo()
                
                if(cheak == true){
                    
                    desTextField.text = userDetail.object.work_address
                    booking.object.DeslocName = userDetail.object.work_address
                    booking.object.dropUpLat = userDetail.object.work_lat
                    booking.object.dropUpLon = userDetail.object.work_lng
                    makeMarker(type: "des")
                    makePolyLine()
                    if(desTextField.text?.characters.count == 0){
                        
                        desPic.image = UIImage(named: "flag")
                        
                        
                    }
                    else{
                        
                        desPic.image = UIImage(named: "colorflag")
                        
                    }
                    
                }else{
                    
                    
                }
                
            }else {
                
                // go to setting
            }
            
        }
        
        
        
    }
    
    
    
    var typeOfButton = ""
    
    
    @IBAction func getSharedHome(_ sender: Any) {
        
        getSharedValue(typeofValue: "HOME", typeOfButton: typeOfButton)
        UIView.animate(withDuration: 0.5, animations: {
            
            self.CollectionViewTwo.frame.origin.y  = self.view.frame.height + 30
            
            self.belowviewMain.isHidden = true
            self.pinToFecthLocation.isHidden = true
        })
        
        
    }
    
    
    // work des
    @IBAction func getSharedWork(_ sender: Any) {
        
        getSharedValue(typeofValue: "WORK", typeOfButton: typeOfButton)
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.CollectionViewTwo.frame.origin.y  = self.view.frame.height + 30
            self.belowviewMain.isHidden = true
        })
        
    }
    
    
    // add home work for Pic location
    @IBAction func buttonTwoAction(_ sender: Any) {
        deRotatepic()
        belowviewMain.isHidden = false
        typeOfButton = "picUpButton"
     
        
        
    }
    
    
    // clicl to open history and home work
    @IBAction func desOneAction(_ sender: Any) {
        DeRotateDesLogo()
      // CollectionViewTwo.isHidden = false
        typeOfButton = "DestButton"
        
        UIView.animate(withDuration: 0.5) {
            
            
            self.CollectionViewTwo.frame = CGRect(x: 0, y: self.mainPicView.frame.height * 2 + self.belowviewMain.frame.height + 5, width: self.view.frame.width-32, height:  self.view.frame.height / 2)
            
            
             self.belowviewMain.isHidden = false
            self.CollectionViewTwo.center.x = self.view.center.x
          
        }

    }
    
    
    
    func rotateDesLogo(){
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.3, options: [], animations: {
            
            
            self.destinationOpenBtn.setBackgroundImage(UIImage(named: "close"), for: UIControlState.normal)
            
            
            self.destinationOpenBtn.frame.origin.x -= 80
            
            self.DesBtnOne.alpha = 1
            self.DesBtnOne.alpha = 1
            self.DesBtnOne.isEnabled = true
            self.desOpenTwo.isEnabled = true
            self.DesBtnOne.isHidden = false
            self.desOpenTwo.isHidden = false
            
            self.picUpTextField.frame = CGRect(x: self.picUpTextField.frame.origin.x, y: self.picUpTextField.frame.origin.y, width: 150, height: self.picUpTextField.frame.height)
             self.desTextField.frame = CGRect(x: self.desTextField.frame.origin.x, y: self.desTextField.frame.origin.y, width: 150, height: self.desTextField.frame.height)
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.5, animations: {
                self.DesBtnOne.frame.origin.x -= 40
                
            })
        }, completion: nil)
        
        desRotate = true
    }
    
    
    func DeRotateDesLogo() {
        
        self.destinationOpenBtn.setBackgroundImage(UIImage(named: "list"), for: UIControlState.normal)
        self.DesBtnOne.isEnabled = false
        self.desOpenTwo.isEnabled = false
        self.DesBtnOne.isHidden = true
        self.desOpenTwo.isHidden = true
        self.picUpTextField.frame = CGRect(x: self.picUpTextField.frame.origin.x, y: self.picUpTextField.frame.origin.y, width: 250, height: self.picUpTextField.frame.height)
        
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.3, options: [], animations: {
            
            self.destinationOpenBtn.frame.origin.x += 80
            
            self.CollectionViewTwo.frame.origin.y  = self.view.frame.height + 30
             self.desTextField.frame = CGRect(x: self.desTextField.frame.origin.x, y: self.desTextField.frame.origin.y, width: 220, height: self.desTextField.frame.height)
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 00.5, animations: {
                  self.belowviewMain.isHidden = true
                self.DesBtnOne.frame.origin.x += 40
                
            })
        }, completion: nil)
        
        desRotate = false
        
      
    }
    
    
    
    func rotatePicLogo(){
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: [], animations: {
            
            
            self.addbuttonOneAnim.setBackgroundImage(UIImage(named: "close"), for: UIControlState.normal)
            
            
            self.addbuttonOneAnim.frame.origin.x -= 80
            
           
            
            self.buttonTwo.alpha = 1
            self.buttonOne.alpha = 1
            self.buttonOne.isEnabled = true
            self.buttonTwo.isEnabled = true
            self.buttonOne.isHidden = false
            self.buttonTwo.isHidden = false
            self.picUpTextField.frame = CGRect(x: self.picUpTextField.frame.origin.x, y: self.picUpTextField.frame.origin.y, width: 170, height: self.picUpTextField.frame.height)
            
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.5, animations: {
                self.buttonOne.frame.origin.x -= 40
                
            })
        }, completion: nil)
        
        rotate = true
        
        
    }
    
    
    func deRotatepic(){
        
        
        self.addbuttonOneAnim.setBackgroundImage(UIImage(named: "list"), for: UIControlState.normal)
        self.buttonOne.isEnabled = false
        self.buttonTwo.isEnabled = false
        self.buttonOne.isHidden = true
        self.buttonTwo.isHidden = true
        self.picUpTextField.frame = CGRect(x: self.picUpTextField.frame.origin.x, y: self.picUpTextField.frame.origin.y, width: 230, height: self.picUpTextField.frame.height)
        
        UIView.animateKeyframes(withDuration: 0.05, delay: 0.3, options: [], animations: {
            
            self.addbuttonOneAnim.frame.origin.x += 80
            
            
            self.desTextField.frame = CGRect(x: self.desTextField.frame.origin.x, y: self.desTextField.frame.origin.y, width: 230, height: self.desTextField.frame.height)
            
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 00.5, animations: {
                self.buttonOne.frame.origin.x += 40
                
            })
        }, completion: nil)
        
        rotate = false
        
        belowviewMain.isHidden = true
        

        
    }
    
    func ButtonPressedforDesLocation() {
        
        
        typeOfButton = "DestButton"
        
        if (desRotate == false)
        {
            rotateDesLogo()
          
            
        } else if (desRotate == true) {
            
            DeRotateDesLogo()
        
            
        }
        
    }
    
    func ButtonPressedforPicLocation(){
        
        typeOfButton = "picUpButton"
        
        if (rotate == false)
        {
            
           rotatePicLogo()
            
        } else if (rotate == true) {
            
            
            deRotatepic()
            
            }
        
    }
    
    var count = 0
    var count2 = 0
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        
        if(textField == desTextField){
            
            if (count == 0){
                
                SetDestinationLocation()
                count2 = 0
                count = 1
            }
            
            
        }else if (textField == picUpTextField ){
            
            count = 0
            if (count2 == 0){
                SetMyLocation()
                count2 = 1
            }
            
        }
        
        return true
    }
    
    
    
    // add animation to pic location
    
    @IBAction func addButtonOne(_ sender: Any) {
        
        ButtonPressedforPicLocation()
        
        
    }
    
    // add animation to des location
    @IBAction func desOpenBtn(_ sender: Any) {
        
        ButtonPressedforDesLocation()
        
      
       
        
    }
    
    
    // pic location get from map cordinate
    @IBAction func buttonOneAction(_ sender: Any) {
        
        pinToFecthLocation.isHidden = false
        deRotatepic()
        
        
    }
    
    // word button
    @IBAction func desBtnOne(_ sender: Any) {
        
        pinToFecthLocation.isHidden = false
         DeRotateDesLogo()
     
        UIView.animate(withDuration: 0.5, animations: {
            
            self.CollectionViewTwo.frame.origin.y  = self.view.frame.height + 30
            self.belowviewMain.isHidden = true
        })
        
        
        
    }
    
 
    func confermToThisRideTapFunc() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "waitingForResponce")
        
        self.present(controller, animated: true, completion: nil)
   
    }
    
   
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        
        let cheak = pinToFecthLocation.isHidden
        
        if(cheak == true){
            
            
        }else if (cheak == false){
            
            if(typeOfButton == "picUpButton"){
                
                rideNowBtn.setTitle("Confirm Location", for: .normal)
                
                picUpindecator.isHidden = false
                picUpindecator.startAnimating()
                picUpTextField.text = ""
                picUpTextField.attributedPlaceholder = NSAttributedString(string: "")
                getCityNameAndCordinate(field: "iniitaial")
                
                
                
            }else if (typeOfButton == "DestButton"){
                
                rideNowBtn.setTitle("Confirm Location", for: .normal)
                
                desIndicator.isHidden = false
                desIndicator.startAnimating()
                desTextField.text = ""
                desTextField.attributedPlaceholder = NSAttributedString(string: "")
                getCityNameAndCordinate(field: "Des")
          
                
                
                
            }
            
            
        }
        
    }
    
    
    func popDownMianMenu(){
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: [ .transitionCurlDown], animations: {
            
            self.BelowViewF.frame.origin.y = self.view.frame.height + self.BelowViewF.frame.height
            
            self.clickMyLocationBtn.isHidden = false
            self.mainPicView.isHidden = false
            self.flipMenuBack.isHidden = false
            self.rideNowBtn.isHidden = false
            self.pinToFecthLocation.isHidden = true
            let downwards = GMSCameraUpdate.scrollBy(x: -50, y: -150)
            self.CoustomMapView.animate(with: downwards)
            
            
        }, completion: nil)
    }
    
    
    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
        if gesture.direction == UISwipeGestureRecognizerDirection.down {
            
            popDownMianMenu()
            

        }
    }
    
    func flipMenu()
    {
        
        pinToFecthLocation.isHidden = true
        self.LeadingContraints.constant = 320
        self.mainPicView.isHidden = true
        self.belowviewMain.isHidden = true
        self.rideNowBtn.isHidden = true
        self.flipMenuButton.isHidden = false
        clickMyLocationBtn.isHidden = true
        flipMenuBack.isHidden = false
        self.CollectionViewTwo.isHidden = true
        
        self.CoustomMapView.alpha = 0.8
        
        flipViewMain.layer.masksToBounds = false
        flipViewMain.layer.shadowColor = UIColor.black.cgColor
        flipViewMain.layer.shadowOpacity = 1
        flipViewMain.layer.shadowRadius = 30
        
        self.BelowViewF.frame.origin.y = self.BelowViewF.frame.origin.y + self.BelowViewF.frame.height
  
    }
    
    
    func flibBackMenu(){
        
        
            
        self.CoustomMapView.alpha = 1
        self.mainPicView.isHidden = false
        self.belowviewMain.isHidden = false
        self.rideNowBtn.isHidden = false
        self.flipMenuButton.isHidden = false
        self.flipMenuBack.isHidden = true
        self.clickMyLocationBtn.isHidden = false
        self.CollectionViewTwo.isHidden = false
        self.LeadingContraints.constant = 0
        
       
        
    }
    

    
    func GoodToGo()-> Bool{
        
        if(booking.object.dropUpLat  == ""){
            
            return true
        }
        
    
        else if( booking.object.picUpLat == booking.object.dropUpLat ){
            
            
            let lert =  alert.object.alertForSignin(title: "OPS!", message: "Kindly select different Locations")
            self.present(lert, animated: true, completion: nil)
            return false
            
        }else {
            
            return true
        }
    }
    
    
    
    var defaultMarker:GMSMarker?

    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.resignFirstResponder()
        return true
    }
    
    
    
    func getPlacemarkFromLocation(location: CLLocation){
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (error != nil) {
                    
                    print("reverse geodcode fail: \(String(describing: error?.localizedDescription))"
                        
                        
                    )}
                else {
                let pm = placemarks!
                
                if pm.count > 0 {
                    
                    
                    self.picUpTextField.text = pm[0].name!
                    
                    print(pm[0].name!)
                    booking.object.currentlocName = "\(pm[0].name!)"
                    
                    self.fetchUserInfo()
                    
                    if(self.picUpTextField.text?.characters.count == 0){
                        
                        self.flagPic.image = UIImage(named: "location-2")
                        
                    }
                    else{
                        
                        self.flagPic.image = UIImage(named: "colorlocation")
                        
                    }
                    
                }
                }
        })
    }
    
    
   
  
    var initialMarker = GMSMarker()
    
    func coustomLocationFunction(lat:Double , lon:Double , name:String){
     
        self.CoustomMapView.isMyLocationEnabled = true
       
        
        let position = CLLocationCoordinate2D(latitude: lat, longitude:lon)
        let marker = GMSMarker(position: position)
        marker.icon = GMSMarker.markerImage(with: UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1))
        defaultMarker  = marker
        marker.title = name
    
        
        
        initialMarker = marker
        marker.map = CoustomMapView
    }
        var dropMarker:GMSMarker?
    
    func removePreviosMarker(Type:String){
        
        
        if(Type == "pic"){
            
            if(defaultMarker != nil){
                
                defaultMarker?.map = nil
                defaultMarker = nil
            }
        }
        
        else if (Type == "des"){
            
            if(dropMarker != nil){
                
                dropMarker?.map = nil
                dropMarker = nil
            }
            
        }
        
    }
    

    func makeMarker(type:String){
        
        
        
        if(type == "pic"){
            removePreviosMarker(Type: "pic")
            let position = CLLocationCoordinate2D(latitude: (Double(booking.object.picUpLat))!, longitude:(Double(booking.object.picUpLon))!)
            
            let marker = GMSMarker(position: position)
            
            marker.icon = GMSMarker.markerImage(with: UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1))
            
            defaultMarker  = marker
            
            marker.map = CoustomMapView
            
            
        }else if (type == "des"){
        
            removePreviosMarker(Type: "des")
            
            let position = CLLocationCoordinate2D(latitude: (Double(booking.object.dropUpLat))!, longitude:(Double(booking.object.dropUpLon))!)
            
            let marker = GMSMarker(position: position)
            
            marker.icon = GMSMarker.markerImage(with: UIColor.blue)
            
            dropMarker  = marker
            
            marker.map = CoustomMapView
            
            
        }
        
        
        
    }

    func clickMyLocationFunction(){
        
        removePreviosMarker(Type: "pic")
        
       
        
        
        if CLLocationManager.locationServicesEnabled() {
            Manager.startUpdatingLocation()
            
        }
        
        if (Manager.location?.coordinate.longitude != nil){
            
            let location = CLLocation(latitude: (Manager.location!.coordinate.latitude), longitude: (Manager.location!.coordinate.longitude))
            

            getPlacemarkFromLocation(location: location)

          
     
            self.CoustomMapView.delegate = self
            self.CoustomMapView.isMyLocationEnabled = true
            self.CoustomMapView.settings.zoomGestures = true
            
            let position = CLLocationCoordinate2D(latitude: (Manager.location?.coordinate.latitude)!, longitude:(Manager.location?.coordinate.longitude)!)
            
            let marker = GMSMarker(position: position)
            
            marker.icon = GMSMarker.markerImage(with: UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1))
            
            defaultMarker  = marker
            
            CoustomMapView.animate(toLocation:position )
            CoustomMapView.animate(toZoom: 16)
            
            booking.object.picUpLat = "\(String(describing: Manager.location!.coordinate.latitude))"
            booking.object.picUpLon = "\(String(describing: Manager.location!.coordinate.longitude))"

            marker.map = CoustomMapView
            
        }
        
    }
    
    

    
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
    
    
    struct OldMarKer {
        
        var driverId = ""
        var Marker = GMSMarker()
       
    }
    
    
    var OldMarkerStruct = [OldMarKer]()
    
    var OldRotateLocations = [CLLocationCoordinate2D]()
    
    

    
    var imgg = UIImage()

    
    var position = CLLocationCoordinate2D()
    
    func temp(){
        
        for i in self.OldMarkerStruct {
            
          
            if(nearestDriverController.nearestdriver!.driverid == i.driverId){
                
                
                self.position = i.Marker.position
                
                i.Marker.position = CLLocationCoordinate2D(latitude: Double((nearestDriverController.nearestdriver!.lat))!, longitude: Double((nearestDriverController.nearestdriver!.lon))!)
                
                
                self.UpdateNewMarker(New: i.Marker)
            }
            
        }
        
    }
    
    
 
    
    
    @IBAction func RideNowFunction(_ sender: Any) {
        

        let cheak = rideNowBtn.titleLabel?.text
        
        
        if(cheak == "Confirm Location"){
            
            pinToFecthLocation.isHidden = true
            rideNowBtn.setTitle("Ride Now", for: .normal)
            
        }else{
        
        
        if( booking.object.dropUpLat == ""){
            SetDestinationLocation()
            
        }else if (booking.object.picUpLat == ""){
            SetMyLocation()
            
        }else {
             popUpBelowMenu()

        }
        }
    }
    
    
    
    func popUpBelowMenu(){
    
    pinToFecthLocation.isHidden = true
    self.flipMenuButton.isHidden = true
    mainPicView.isHidden = true
    belowviewMain.isHidden = true
    clickMyLocationBtn.isHidden = true
    self.flipMenuBack.isHidden = true
    
    
    
    if(booking.object.dropUpLat != "" && booking.object.picUpLat != ""){
    self.rideNowBtn.isHidden = true
    UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
    
    self.BelowViewF.frame.origin.y = self.view.frame.height - self.BelowViewF.frame.height
    self.CollectionViewOne.frame.origin.x = 0
    self.CollectionViewOne.frame.origin.y = 0
    let downwards = GMSCameraUpdate.scrollBy(x: 50, y: 150)
    self.CoustomMapView.animate(with: downwards)
    
    }, completion: nil)

    
    }
    
    
    }
    
    
    
    @IBAction func rideLaterAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let Controller = storyBoard.instantiateViewController(withIdentifier: "calender")
        self.present(Controller, animated: true, completion: nil)
    
        
        
    }
    
    
    
    func performSegureCoustom(Identifer:String){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let Controller = storyBoard.instantiateViewController(withIdentifier: "\(Identifer)")
        self.present(Controller, animated: true, completion: nil)
        
    }
    
    
    @IBAction func RequestRideFunciton(_ sender: Any) {
        let cheak =  UserDefaults.standard.value(forKey: "paymentMethod")
        
        if(cheak != nil){
            
            
            if(String(describing: cheak!) == "craditCard" ){
        
                booking.object.payment = "CreditCards"
                performSegureCoustom(Identifer: "waitingForResponce")
                
            }else if (String(describing: cheak!) == "paypal"){
                
                if(booking.object.paypalPass == false){
                    
                    booking.object.RideNowBtnPress = true
                    performSegureCoustom(Identifer: "scanCard")
                  
                    
                }else {
                    

                    booking.object.payment = "PayPal"
                    booking.object.paypalPass = false
                     performSegureCoustom(Identifer: "waitingForResponce")

                }
               
                
            }else if (String(describing: cheak!) == "cash"){
                
                  booking.object.payment = "Cash"
                 performSegureCoustom(Identifer: "waitingForResponce")

                
            }else {
                
                 performSegureCoustom(Identifer: "scanCard")
                
            }
            
        }else{
            
           performSegureCoustom(Identifer: "scanCard")
        }
        
        
    
       
    }
    
    
    
    func UpdateNewMarker( New:GMSMarker){
        
        New.rotation = CLLocationDegrees(getHeadingForDirection(fromCoordinate: position, toCoordinate: New.position))
        
        
        New.map = CoustomMapView
        
        
    }
    
    
    func removeOldMarker(){
        
        for i in OldMarkerStruct {
            
            i.Marker.map = nil
            
        }
        
        
    }
    
    func LoadSpecificCars(){
        
        for (_,j) in nearestDriverController.ANearestDriver.enumerated(){
            
            
            let Boolion =  Chapi.contains(j.taxi_model)
            
            if (Boolion == true){
                
            }else {
                
                Chapi.append(j.taxi_model)
                
            }
        }
        
        
        if(Chapi.count != 0){
            
            VehacialList.instance.FetchVehacial(lat: booking.instance.picUpLat, lon: booking.instance.picUpLon, nearestArray: Chapi, result: { (result) in
                
                
                
                if(result == ""){
                    
                    self.CollectionViewOne.reloadData()
                }
                
                
                
            })
            
        }
    }
    
    
    
    var Chapi = [String]()
    func coustomCarLoad(taxiModal:String) {
        
        removeOldMarker()
        OldMarkerStruct.removeAll()

        var StructObject = OldMarKer()
        
        
        for (_,j) in nearestDriverController.ANearestDriver.enumerated(){
            
             print(j.taxi_model)
             print(taxiModal)
            
            if(j.taxi_model == taxiModal){
              
                
               
                
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: j.lat, longitude: j.lon))
                
     
            
                StructObject.driverId = j.driver_id
              
                EtaTime.text = "\(j.eta_time)"
             
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: NSURL(string: "\(j.MarkerPic)")! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
                    if (IMG != nil){
                        
                        marker.icon = self.scaleImageToSize(img: IMG!, size: CGSize(width: 40.0, height: 40.0))
                        self.imgg = IMG!
                        
                    }
   
                    
                })
                
                
                marker.map = self.CoustomMapView
                StructObject.Marker = marker
                OldMarkerStruct.append(StructObject)
                
                
            }
        }
     // temp()
        
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
    var InfoCheak = false
    var path:GMSMutablePath? = nil
     var array = [CLLocationCoordinate2D]()
    
}

extension ViewController :GMSAutocompleteViewControllerDelegate {
    
    
    
    func SetDestinationLocation() {
        SetorDestination = "Destination"
        
        pinToFecthLocation.isHidden = true
        CollectionViewTwo.isHidden = true
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
    
    
    func SetMyLocation() {
        
        SetorDestination = "Set"
        pinToFecthLocation.isHidden = true
        CollectionViewTwo.isHidden = true
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        
        
        
        if ( SetorDestination == "Set"){
            
            booking.object.picUpLat = "\(place.coordinate.latitude)"
            booking.object.picUpLon = "\(place.coordinate.longitude)"
            booking.object.currentlocName = "\(place.name)"
            

            
            picUpTextField.text = place.name
            
            makeMarker(type: "pic")
            
            if(picUpTextField.text?.characters.count == 0){
                
                flagPic.image = UIImage(named: "location-2")
                
            }
            else{
                
                flagPic.image = UIImage(named: "colorlocation")
                
            }
            
            
            
            
            coustomLocationFunction(lat: place.coordinate.latitude, lon: place.coordinate.longitude, name: place.name)
            
            if(booking.object.dropUpLat != ""){
                
                makePolyLine()
            }
            
            
        }else if ( SetorDestination == "Destination"){
            
            booking.object.dropUpLat = "\(place.coordinate.latitude)"
            booking.object.dropUpLon = "\(place.coordinate.longitude)"
            booking.object.DeslocName = "\(place.name)"
            desTextField.text = place.name
            
            
            
            if(desTextField.text?.characters.count == 0){
                
                desPic.image = UIImage(named: "flag")
                
                
            }
            else{
                
                desPic.image = UIImage(named: "colorflag")
                
            }
            
            
            
            InfoCheak = true
            makeMarker(type: "des")
            makePolyLine()
            
            
            
            
            
            
            
            
            
            
            
            
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
    
    
    
    
    func makePolyLine() {
        
        if (cheakForPolyline == true){
            
            
            RemoveOldPoliLine()
            
        self.fareEstimateFunc(TaxiModal: "40")
            
            cheakForPolyline = false
            
            let destinationCordinate = CLLocationCoordinate2DMake(Double(booking.object.dropUpLat)!, Double(booking.object.dropUpLon)!)
            
            let destination = "\(destinationCordinate.latitude),\(destinationCordinate.longitude)"
         
            
            
            
            let origin = "\(String(describing: booking.object.picUpLat)),\(String(describing:  booking.object.picUpLon))"
   
            
            if(origin != "" && destination != ""){
                
                DispatchQueue.global(qos: .background).async {
                    
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
                         
                                if(point.count != 0){
                                
 
                                    
                                    let u = GMSMutablePath(fromEncodedPath: point[0] as! String)
                                    
                                    
                                    
                                    
                                    let polylin = Polyline(encodedPolyline: point[0] as! String)
                                    
                      
                                    for i in polylin.coordinates! {
                                        
                                        self.array.append(CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude) )
                                    }

                        self.path = u
                                    
                                    let rectangle = GMSPolyline(path: u!)
                                   
                                    rectangle.strokeWidth = 4
                                    rectangle.strokeColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1)
                                    
                                    self.OldPPolyline = rectangle
                                    rectangle.map = self.CoustomMapView
                                    
                                    self.cheakForPolyline = true
                                    
                                }
                                else{
                                    
                                    let controller = alert.object.alertForSignin(title: "Alert!", message: "Make sure you have Chosen Right Path!")
                                    self.cheakForPolyline = true
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
        }
    }
    
    
    func removeOnepolyline(lat:Double , lon:Double){
        
     let coordinate₀ = CLLocation(latitude:  lat, longitude:  lon)
    let coordinate₁ = CLLocation(latitude:  array[0].latitude, longitude:  array[0].longitude)

        
        if(coordinate₀.distance(from: coordinate₁) < 5.0){
            
            
            OldPPolyline?.map = nil
            
            let u = path
            
            u?.removeCoordinate(at: UInt(0))
            array.remove(at: 0)
            let rectangle = GMSPolyline(path: u!)
            
            rectangle.strokeWidth = 4
            rectangle.strokeColor = UIColor(displayP3Red: 89/255, green: 193/255, blue: 211/255, alpha: 1)
            
            self.OldPPolyline = rectangle
            rectangle.map = self.CoustomMapView
            
        }

        
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        //removeOnepolyline(lat:coordinate.latitude , lon: coordinate.longitude)
        print(coordinate.latitude)
        print(coordinate.longitude)
    }
    
    
    

    
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
       
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

extension ViewController:UICollectionViewDataSource , UICollectionViewDelegate{
    
    



    func numberOfSections(in collectionView: UICollectionView) -> Int {
   
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == self.CollectionViewOne){
            
               return VehacialList.VehacialListArray.count
        }else {
           
            return ImportHistory.historyArray.count
            
        }
        
    }
    
   

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if(collectionView == self.CollectionViewOne){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath) as! CollectionViewCell
            
            cell.configrationOfCell(name:VehacialList.VehacialListArray[indexPath.item].name , ImgURL: VehacialList.VehacialListArray[indexPath.item].icon )
 
            return cell
        }
        else {
            
             let cellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: "CellTwo", for: indexPath) as! historyPickUp
            
            cellTwo.label.text = ImportHistory.historyArray[indexPath.item].drop_location
            return cellTwo
            
        }
       
    }

    func fareEstimateFunc(TaxiModal:String){
        
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let result = formatter.string(from: date)
        
        booking.object.pic_Date = result
        
        
        fareEstimate.object.fareEstimateFunction(taxiModel:TaxiModal ) { (RESULT) in
            
            if (RESULT == ""){
                
               
                self.showFare.text = booking.object.fareEstimate
                self.MaxPeople.text = "\(booking.object.max_passenger) People"
                booking.object.max_passenger = booking.object.max_passenger
                self.EtaTime.text = booking.object.total_duration
                booking.object.texi_Modal = TaxiModal
                self.Luggage.text = "\(booking.object.max_luggage) Box"
                self.taxiType.text = "\(booking.object.texi_Modal)"
                
                
                
            }else {
                
                print("Nahi aya")
            }
        }
        
   
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == self.CollectionViewOne){
           
       print(VehacialList.VehacialListArray[indexPath.item].typeid)
              print(VehacialList.VehacialListArray[indexPath.item].name)
            
            fareEstimateFunc(TaxiModal:VehacialList.VehacialListArray[indexPath.item].typeid)
            booking.object.texi_Modal = VehacialList.VehacialListArray[indexPath.item].typeid
            fareEstimateFunc(TaxiModal: VehacialList.VehacialListArray[indexPath.item].typeid)
        coustomCarLoad(taxiModal: VehacialList.VehacialListArray[indexPath.item].typeid)
            
            
        }else {
            
            
      let info = ImportHistory.historyArray[indexPath.item]
           
            
            booking.object.dropUpLat = info.drop_lat!
            booking.object.dropUpLon = info.drop_lng!
            booking.object.DeslocName = info.drop_location!
            self.desTextField.text = info.drop_location!
            makeMarker(type: "des")
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.CollectionViewTwo.frame.origin.y  = self.view.frame.height + 30
                  self.belowviewMain.isHidden = true
            })
            
            
            if(booking.object.dropUpLat != "" && booking.object.dropUpLon != ""){
                
                makePolyLine()
                desPic.image = UIImage(named: "colorflag")
                
            }
           
            
        }
        
   
        
    }
    
 
    
}



extension ViewController:UITableViewDataSource, UITableViewDelegate {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTwo", for: indexPath) as! TableViewCell
        
        cell.settingLabel.text = Options[indexPath.row]
        cell.settingPic.image = UIImage(named: white[indexPath.row])
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellToDeSelect = tableView.cellForRow(at: indexPath)! as! TableViewCell
        cellToDeSelect.contentView.backgroundColor = UIColor.white
        cellToDeSelect.settingPic.image = UIImage(named: black[indexPath.row])
        
        
        
        if(indexPath.row == 0){
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "scanCard")
            present(controller, animated: true, completion: nil)
            
        }else if (indexPath.row == 1){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "History")
            present(controller, animated: true, completion: nil)
            
        }
        else if (indexPath.row == 2){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "promotionScreen")
            present(controller, animated: true, completion: nil)
           
            
        }else if (indexPath.row == 3){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "PromoCode")
            present(controller, animated: true, completion: nil)
            
            
        }else if (indexPath.row == 4){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "setting")
            present(controller, animated: true, completion: nil)
            
        }else if (indexPath.row == 5){
            
            let message = UIAlertController(title:"Alert" , message: "Are you sure you wants to logoff", preferredStyle: UIAlertControllerStyle.alert)
            
            let Action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive) { (UIAlertAction) in
                
                UserDefaults.standard.set("", forKey: "token")
                UserDefaults.standard.set("", forKey: "fname")
                UserDefaults.standard.set("", forKey: "UID")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "Login")
                self.present(controller, animated: true, completion: nil)
                
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
            }
            message.addAction(cancel)
            message.addAction(Action)
            
            self.present(message, animated: true, completion: nil)
            
        }else if (indexPath.row == 6){
            
            performSegureCoustom(Identifer: "contactUsTable")
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        let cellToDeSelect = tableView.cellForRow(at: indexPath)! as! TableViewCell
        cellToDeSelect.contentView.backgroundColor = UIColor.clear
        cellToDeSelect.settingPic.image = UIImage(named: white[indexPath.row])
        
    }
    

    
}







