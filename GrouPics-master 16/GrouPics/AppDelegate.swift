//
//  AppDelegate.swift
//  GrouPics
//
//  Created by Tom and Andrew on 3/26/16.
//  Copyright © 2016 Tom. All rights reserved.
//

import UIKit
import Firebase
import GeoFire
import GoogleMaps

// database reference
var dataBase : Firebase = Firebase()
//obtain views
var tabBarController : UITabBarController = UITabBarController()
var tempView : UIViewController = UIViewController()
var storyboard : UIStoryboard = UIStoryboard()
//screen size
let screenSize: CGRect = UIScreen.mainScreen().bounds
//unique user identifier
var userID: String = String()
//other global vars
var eventName : String = String()
var eventsNavLocal : Int = 0
var onOpen : Bool = true
var tempImg: UIImage = UIImage()
var pickerController = UIImagePickerController()
var refresh: Int = 0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        dataBase = Firebase(url:"https://groupics333.firebaseio.com/")
        let tabBarController = self.window!.rootViewController as? UITabBarController
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let item1 = (tabBarController?.tabBar.items![0])! as UITabBarItem
        userID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        //setting up google maps
        GMSServices.provideAPIKey("AIzaSyB4bEVGKuvtQLLnCVRIcXKzWfh7aocN_qc")
        
        
        let userRef = dataBase.childByAppendingPath("users/")
        userRef.observeEventType(.Value, withBlock: { snapshot in
            if !snapshot.hasChild(userID) {
                let userIDRef = dataBase.childByAppendingPath("users/" + userID)
                let tempRef = userIDRef.childByAppendingPath("hosted events/null")
                tempRef.setValue("null")
                let tempRef2 = userIDRef.childByAppendingPath("joined events/null")
                tempRef2.setValue("null")
            }
        })

        
        
        return true
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

