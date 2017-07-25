


//
//  AppDelegate.swift
//  Cabigate
//
//  Created by abdur rehman on 5/27/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleMaps
import  GooglePlaces
import UserNotifications




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?
    let object = Signin()
  
     let reachability = Reachability()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
        
        contectUs.object.contectUsFun { (res) in
            
            if(res == ""){
                print(contectUsModal.object.paypal_email)
                PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "\(contectUsModal.object.paypal_email)",
                                                                       PayPalEnvironmentSandbox: "\(contectUsModal.object.paypal_email)"])
            }

        }
        
      
        
        
        GMSServices.provideAPIKey("AIzaSyBGUYwBUwXu6rLrS3T4BRvjSqBXKGoHkI0")
        GMSPlacesClient.provideAPIKey("AIzaSyBv_lNOo0xHiY0RAMJuHF5IDdlYKv96OKU")
        
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
  
        
   
        registerForPushNotifications()

        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
   Authantication()
        
    
        return true
    }
    
    func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi  {
                
                DispatchQueue.main.async {
                    
                    self.pinMainView()
                   
  
                }
            }else{
                
                DispatchQueue.main.async {
                self.pinMainView()
                }
            }
        } else {
            DispatchQueue.main.async {
               
                let controller = self.makeSegue(Name: "Wifi")
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            }
        }
    }

    
    func pinMainView(){
        let result = UserDefaults.standard.value(forKey: "State")
        
        if let temp = result as? NSDictionary{
            
            let u  = (temp["status"] as? String)!
            
            if(u == ""){
                //MaP
                let controller = self.makeSegue(Name: "Map")
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
                
            }else {
                
                let controller = self.makeSegue(Name: "waiting")
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
                
            }
            
        }
    }
    
    func makeSegue(Name:String)->UIViewController {
        
        let storyBord = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBord.instantiateViewController(withIdentifier: "\(Name)")
        return controller
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        print("im running")
        
    }
    
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    
    
    func Authantication() {
        
        let result = UserDefaults.standard.value(forKey: "token")
        let UID = UserDefaults.standard.value(forKey: "UID")
        
        if(result != nil){

        if(String(describing: result!) != "" ){
         
             userData.object.token = String(describing: result!)
             userData.object.uId = String(describing: UID!)
            
            let result = UserDefaults.standard.value(forKey: "State")
            
            
            if let temp = result as? NSDictionary{
                
                let u  = (temp["status"] as? String)!
                
               
                
                if(u == ""){
                    //Map
                    let controller = self.makeSegue(Name: "Map")
                    self.window?.rootViewController = controller
                    self.window?.makeKeyAndVisible()
                    
                }else {
                    
                    let controller = self.makeSegue(Name: "waiting")
                    self.window?.rootViewController = controller
                    self.window?.makeKeyAndVisible()
                    
                }
                
            }else {
                //Map
                let controller = self.makeSegue(Name: "Login")
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
                
            }
            
            
        }else{
            
            let controller = self.makeSegue(Name: "Login")
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
        }
  
        }else {
            
            let controller = self.makeSegue(Name: "Login")
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
        }
    }

}

