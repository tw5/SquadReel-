//
//  EventDetailsViewController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 4/12/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// allows users to learn more about event before joining

import UIKit

class EventDetailsViewController: UIViewController {
    var alert = UIAlertController()
    var passwordString : String = String()
    var passwordAttempt: UITextField = UITextField()
    var searchView: UIViewController = UIViewController()
    var nameLabel = UILabel()
    let image = UIImageView()

    // create titles and buttons
    override func viewDidAppear(animated: Bool) {
        let title = eventName.componentsSeparatedByString("^")[0]
        nameLabel.text = title
        
        let eventRef = dataBase.childByAppendingPath("events/" + eventName)
        let picturesRef = eventRef.childByAppendingPath("cover photo/")
        var pictureString : String = String()
        var pic : UIImage = UIImage()
        picturesRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            pictureString = snapshot.value as! String
            if pictureString != "" {
                let pictureData = NSData(base64EncodedString: pictureString, options:NSDataBase64DecodingOptions(rawValue: 0))
                pic = UIImage(data: pictureData!)!
                self.image.image = pic
                self.image.frame.size.width = screenSize.width
                self.image.frame.size.height = screenSize.width * (pic.size.height/pic.size.width)
                self.image.frame.origin.x = (screenSize.width - self.image.frame.size.width)/2
                self.image.frame.origin.y = (screenSize.height - self.image.frame.size.height)/2
                
            }
        })
        
    }
    
    // create titles and buttons
    override func viewDidLoad() {
        searchView = storyboard!.instantiateViewControllerWithIdentifier("searchEventsView") as UIViewController

        super.viewDidLoad()
        let leafGreenColor = UIColor(red: 108/255.0, green: 177/255.0, blue: 115/255.0, alpha: 0.5)
        let title = eventName.componentsSeparatedByString("^")[0]
        let count = title.characters.count
        nameLabel.backgroundColor = leafGreenColor
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.text = title
        nameLabel.textAlignment = .Center
        nameLabel.font = UIFont(name: "Menlo", size: (50 - CGFloat(count)) * (screenSize.width/375))
        nameLabel.frame = CGRectMake(0, 0, screenSize.width, screenSize.height * 0.12)
        nameLabel.frame.origin.x = (screenSize.width - nameLabel.frame.size.width)/2
        //nameLabel.frame.origin.y = (screenSize.height - nameLabel.frame.size.height)/2
        nameLabel.frame.origin.y = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.sharedApplication().statusBarFrame.size.height//(screenSize.height * 0.1)
        nameLabel.alpha = 1.0
        nameLabel.layer.cornerRadius = 10
        
        let dbutton = UIButton()
        dbutton.titleLabel!.font = UIFont(name: "Arial", size: 21*screenSize.width/320)
        dbutton.setTitle("Event Details", forState: UIControlState.Normal)
        dbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        dbutton.backgroundColor = leafGreenColor
        dbutton.frame = CGRectMake(0, 0, screenSize.width * 0.5, screenSize.height * 0.1)
        dbutton.frame.origin.x = (screenSize.width - dbutton.frame.size.width)/2
        dbutton.frame.origin.y = ((screenSize.height) / 2 - dbutton.frame.size.height/2)
        dbutton.alpha = 1.0
        dbutton.layer.cornerRadius = 10
        
        dbutton.addTarget(self, action: #selector(EventDetailsViewController.detailAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        let button = UIButton()
        button.titleLabel!.font = UIFont(name: "Arial", size: 21*screenSize.width/320)
        button.setTitle("Join Event", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.backgroundColor = leafGreenColor
        button.frame = CGRectMake(0, 0, screenSize.width * 0.5, screenSize.height * 0.1)
        button.frame.origin.x = (screenSize.width - button.frame.size.width)/2
        button.frame.origin.y = (screenSize.height - button.frame.size.height - 50)
        button.alpha = 1.0
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(EventDetailsViewController.joinAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(image)
        self.view.addSubview(nameLabel)
        self.view.addSubview(button)
        self.view.addSubview(dbutton)
        
    }
    
    // when user clicks join, perform necessary actions
    func joinAction(sender:UIButton!) {
        
        let eventRef = dataBase.childByAppendingPath("events/" + eventName)
        let passwordRef = eventRef.childByAppendingPath("password/")
        let userRef = dataBase.childByAppendingPath("users/" + userID)
        let userEventsRef = userRef.childByAppendingPath("joined events/" + eventName)
        // prompt for password if necessary
        passwordRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            self.passwordString = snapshot.value as! String
            if self.passwordString != "" {
                let actionSheetController: UIAlertController = UIAlertController(title: "Join Event", message: "Please enter the password", preferredStyle: .Alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) {action -> Void in
                }
                actionSheetController.addAction(cancelAction)
                
                actionSheetController.addTextFieldWithConfigurationHandler{textField -> Void in
                    //textField.textColor = UIColor.blueColor()
                    textField.placeholder = "password"
                    textField.secureTextEntry = true
                    self.passwordAttempt = textField
                }
                
                let nextAction: UIAlertAction = UIAlertAction(title: "Next", style: .Default) {action -> Void in
                    
                    if (self.passwordAttempt.text == self.passwordString) {
                        userEventsRef.setValue(eventName)
                        self.tabBarController!.selectedIndex = 2
                        searchEventsNavController.pushViewController(self.searchView, animated: false)
                    }
                    else {
                        let alert = UIAlertView()
                        alert.title = "Incorrect Password"
                        alert.message = "Try again or confirm with your host"
                        alert.addButtonWithTitle("Understood")
                        alert.show()
                    }
                }
                actionSheetController.addAction(nextAction)
                self.presentViewController(actionSheetController, animated: true, completion: nil)
            }
            else {
                userEventsRef.setValue(eventName)
                self.tabBarController!.selectedIndex = 2
                searchEventsNavController.pushViewController(self.searchView, animated: false)
            }

        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    // show more details if user clicks
    func detailAction(sender:UIButton!)
    {
        var des : String = String()
        var endTime: String = String()
        var month: String = String()
        var amOrpm: String = String()
        var hour: String = String()
        var hr: Int = Int()
        let eventRef = dataBase.childByAppendingPath("events/" + eventName)
        let descriptionRef = eventRef.childByAppendingPath("description/")
        let timeRef = eventRef.childByAppendingPath("end time/")
        // obtain description and end time
        descriptionRef.observeEventType(.Value, withBlock: { snapshot in
            des = snapshot.value as! String
            timeRef.observeEventType(.Value, withBlock: { snapshot in
                endTime = snapshot.value as! String
                
                let year =  endTime.substringWithRange(endTime.startIndex.advancedBy(6)..<endTime.endIndex.advancedBy(-6))
                let day =  endTime.substringWithRange(endTime.startIndex.advancedBy(0)..<endTime.endIndex.advancedBy(-14))
                let mon =  endTime.substringWithRange(endTime.startIndex.advancedBy(3)..<endTime.endIndex.advancedBy(-11))
                let min = endTime.substringWithRange(endTime.startIndex.advancedBy(13)..<endTime.endIndex.advancedBy(0))
                hour = endTime.substringWithRange(endTime.startIndex.advancedBy(11)..<endTime.endIndex.advancedBy(-3))
                if mon == "01"
                {
                    month = "January"
                }
                else if mon == "02"
                {
                    month = "February"
                }
                else if mon == "03"
                {
                    month = "March"
                }
                else if mon == "04"
                {
                    month = "April"
                }
                else if mon == "05"
                {
                    month = "May"
                }
                else if mon == "06"
                {
                    month = "June"
                }
                else if mon == "07"
                {
                    month = "July"
                }
                else if mon == "08"
                {
                    month = "August"
                }
                else if mon == "09"
                {
                    month = "September"
                }
                else if mon == "10"
                {
                    month = "October"
                }
                else if mon == "11"
                {
                    month = "November"
                }
                else if mon == "12"
                {
                    month = "December"
                }
                
                hr = Int(hour)!
                if (hr < 12)
                {
                    amOrpm = "AM"
                }
                else if (hr >= 12)
                {
                    amOrpm = "PM"
                }
                hr = hr % 12
                if (hr == 0)
                {
                    hr = 12
                }
                let alert = UIAlertView()
                alert.title = "Event Information"
                alert.message = "Description: " + des + "\nEnd Time: " + String(hr) + min + " " + amOrpm + " on " + month + " " + day + ", " + year
                alert.addButtonWithTitle("Understood")
                alert.show()
            })
        })
        
        
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

