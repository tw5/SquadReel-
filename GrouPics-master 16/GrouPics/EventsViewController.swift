//
//  EventsNavigationController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 3/28/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// allow users to view all events

import UIKit
import Firebase

class EventsViewController: UIViewController {

    var hostButtonCount : Int!
    var hostConcludedButtonCount : Int!
    var joinButtonCount : Int!
    var joinConcludedButtonCount : Int!
    var pastButtonCount : Int!
    
    var scrollView: UIScrollView!
    var scrollView2: UIScrollView!
    
    let scrollButton = UIButton()
    let scrollButton2 = UIButton()
    let scrollLabelBackground = UILabel()
    let scrollLabelBackground2 = UILabel()
    
    let darkRedColor = UIColor(red: 109/255.0, green: 32/255.0, blue: 24/255.0, alpha: 1.0)
    let darkGreenColor = UIColor(red: 19/255.0, green: 35/255.0, blue: 19/255.0, alpha: 1.0)
    let lightGreenColor = UIColor(red: 199/255.0, green: 215/255.0, blue: 198/255.0, alpha: 1.0)
    let lightOrangeColor = UIColor(red: 232/255.0, green: 180/255.0, blue: 80/255.0, alpha: 1.0)
    let lightWhiteColor = UIColor(red: 251/255.0, green: 249/255.0, blue: 249/255.0, alpha: 1.0)
    let darkOrangeColor = UIColor(red: 159/255.0, green: 108/255.0, blue: 8/255.0, alpha: 1.0)
    let dullPurpleColor = UIColor(red: 167/255.0, green: 147/255.0, blue: 174/255.0, alpha: 1.0)
    let dullRedColor = UIColor(red: 193/255.0, green: 113/255.0, blue: 104/255.0, alpha: 1.0)
    let dullYellowColor = UIColor(red: 219/255.0, green: 197/255.0, blue: 96/255.0, alpha: 1.0)
    let purplyRedColor = UIColor(red: 140/255.0, green: 91/255.0, blue: 107/255.0, alpha: 1.0)
    let dullOrangeColor = UIColor(red: 177/255.0, green: 145/255.0, blue: 108/255.0, alpha: 1.0)
    let orangyYellowColor = UIColor(red: 222/255.0, green: 174/255.0, blue: 122/255.0, alpha: 1.0)
    let normRedColor = UIColor(red: 186/255.0, green: 94/255.0, blue: 85/255.0, alpha: 1.0)

    var yPos: CGFloat = 20
    var yPosConcluded: CGFloat = 20
    var eventView: UIViewController = UIViewController()
    
    // create titles and scrollview
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        eventView = storyboard.instantiateViewControllerWithIdentifier("eventView") as UIViewController
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
        
        //let timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "removeEvents", userInfo: nil, repeats: true)

        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.lightGrayColor()
        scrollView.autoresizingMask = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        scrollView.frame = CGRectMake(0, 0, screenSize.width*0.88 + (2 + 0.5 * (4-1)) * 5, screenSize.height*0.65)
        scrollView.frame.origin.x = (screenSize.width - scrollView.frame.width)*0.5
        scrollView.frame.origin.y = screenSize.height*0.23
        let diff = screenSize.height/14
        scrollView.frame.size.height -= diff
        scrollView.frame.origin.y += diff
        
        scrollView2 = UIScrollView()
        scrollView2.backgroundColor = UIColor.lightGrayColor()
        scrollView2.autoresizingMask = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        scrollView2.frame = CGRectMake(0, 0, screenSize.width*0.88 + (2 + 0.5 * (4-1)) * 5, screenSize.height*0.65)
        scrollView2.frame.origin.x = (screenSize.width - scrollView2.frame.width)*0.5
        scrollView2.frame.origin.y = screenSize.height*0.23
        scrollView2.frame.size.height -= diff
        scrollView2.frame.origin.y += diff
        scrollView2.alpha = 0.0
        self.view.addSubview(scrollView2)
        
        scrollLabelBackground.backgroundColor = darkRedColor
        scrollLabelBackground.frame = CGRectMake(0, 0, scrollView.frame.size.width/1.5, screenSize.height * 0.03)
        scrollLabelBackground.frame.origin.x = scrollView.frame.origin.x
        scrollLabelBackground.frame.origin.y = scrollView.frame.origin.y - scrollLabelBackground.frame.size.height
        
        scrollLabelBackground2.backgroundColor = UIColor.whiteColor()
        scrollLabelBackground2.frame = CGRectMake(0, 0, scrollView.frame.size.width/1.5, screenSize.height * 0.03)
        scrollLabelBackground2.frame.origin.x = scrollView.frame.origin.x + scrollView.frame.size.width/3
        scrollLabelBackground2.frame.origin.y = scrollView.frame.origin.y - scrollLabelBackground2.frame.size.height

        scrollButton.setTitle("active", forState: UIControlState.Normal)
        scrollButton.backgroundColor = darkRedColor
        scrollButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        scrollButton.titleLabel?.textAlignment = .Center
        scrollButton.titleLabel?.font = UIFont(name: "Menlo", size: 16*screenSize.width/320)!
        scrollButton.frame = CGRectMake(0, 0, scrollView.frame.size.width/2, screenSize.height * 0.06)
        scrollButton.frame.origin.x = (screenSize.width  - scrollButton.frame.size.width)/2 - scrollView.frame.size.width/3.99
        scrollButton.frame.origin.y = scrollView.frame.origin.y - scrollButton.frame.size.height
        scrollButton.clipsToBounds = true
        scrollButton.layer.cornerRadius = 10
        scrollButton.addTarget(self, action: "activeAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        scrollButton2.setTitle("concluded", forState: UIControlState.Normal)
        scrollButton2.backgroundColor = UIColor.whiteColor()
        scrollButton2.setTitleColor(darkRedColor, forState: UIControlState.Normal)
        scrollButton2.titleLabel?.textAlignment = .Center
        scrollButton2.titleLabel?.font = UIFont(name: "Menlo", size: 16*screenSize.width/320)!
        scrollButton2.frame = CGRectMake(0, 0, scrollView.frame.size.width/2, screenSize.height * 0.06)
        scrollButton2.frame.origin.x = (screenSize.width  - scrollButton2.frame.size.width)/2 + scrollView.frame.size.width/3.99
        scrollButton2.frame.origin.y = scrollView.frame.origin.y - scrollButton2.frame.size.height
        scrollButton2.clipsToBounds = true
        scrollButton2.layer.cornerRadius = 10
        scrollButton2.addTarget(self, action: "concludedAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(scrollLabelBackground2)
        self.view.addSubview(scrollLabelBackground)
        self.view.addSubview(scrollButton)
        self.view.addSubview(scrollButton2)
        
        hostButtonCount = 0
        hostConcludedButtonCount = 0
        joinButtonCount = 0
        joinConcludedButtonCount = 0

        self.view.addSubview(scrollView)

    }
    
    override func viewWillAppear(animated: Bool) {
        if eventsNavLocal == 1 {
            eventsNavLocal = 0
            eventsNavController.pushViewController(eventView, animated: false)
        }
        self.navigationController?.navigationBarHidden = true
        tabBarController!.tabBar.hidden = false
        
    }
    
    //query the user's events
    override func viewDidAppear(animated: Bool) {
        for btn in scrollView.subviews {
            btn.removeFromSuperview()
        }
        for btn in scrollView2.subviews {
            btn.removeFromSuperview()
        }
        yPos = 20
        yPosConcluded = 20
        hostButtonCount = 0
        hostConcludedButtonCount = 0
        joinButtonCount = 0
        joinConcludedButtonCount = 0
        
        // find all hosted events of user
        let hostRef = dataBase.childByAppendingPath("users/" + userID + "/hosted events/")
        hostRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            //let hostEventsName = snapshot.value as! String
            for name in snapshot.children {
                if name.key as! String != "null" {
                    self.updateHostedEvents(name.key as! String)
                }
            }
            hostRef.removeAllObservers()
        })
        
        // find all joined events of user
        let joinRef = dataBase.childByAppendingPath("users/" + userID + "/joined events/")
        joinRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            for name in snapshot.children {
                if name.key as! String != "null" {
                    self.updateJoinedEvents(name.key as! String)
                }
            }
            joinRef.removeAllObservers()
        })
    }
    
    //when clicking event, show it if it hasn't concluded
    func eventAction(sender:Button!) {
        let statusRef = dataBase.childByAppendingPath("events/" + sender.string + "/status/")
        let endTimeRef = dataBase.childByAppendingPath("events/" + sender.string + "/end time/")
        //if it has concluded, update database
        endTimeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            let str = snapshot.value as? String
            if str != nil {
                let eventDate = dateFormatter.dateFromString(str!)
                let date = NSDate()
                let calendar = NSCalendar.currentCalendar()
                var components = calendar.components(.Day, fromDate: date)
                let day = components.day
                components = calendar.components(.Month, fromDate: date)
                let month = components.month
                components = calendar.components(.Year, fromDate: date)
                let year = components.year
                components = calendar.components(.Hour, fromDate: date)
                let hour = components.hour
                components = calendar.components(.Minute, fromDate: date)
                let min = components.minute
                let timestamp: String = "\(day)-\(month)-\(year) \(hour):\(min)"
                let currentDate = dateFormatter.dateFromString(timestamp)
                if eventDate?.compare(currentDate!) == .OrderedAscending {
                    let localRef = dataBase.childByAppendingPath("/locations/\(sender.string)/")
                    localRef.removeValue()
                    statusRef.setValue("concluded")
                }
            }
        })
        eventName = sender.string
        eventsNavController.pushViewController(eventView, animated: true)
    }
    
    //display active events
    func activeAction(sender:Button!) {
        scrollButton.backgroundColor = darkRedColor
        scrollButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        scrollButton2.backgroundColor = UIColor.whiteColor()
        scrollButton2.setTitleColor(darkRedColor, forState: UIControlState.Normal)
        scrollLabelBackground.backgroundColor = darkRedColor
        scrollLabelBackground2.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(scrollLabelBackground2)
        self.view.addSubview(scrollLabelBackground)
        self.view.addSubview(scrollButton)
        self.view.addSubview(scrollButton2)
        scrollView.alpha = 1.0
        scrollView2.alpha = 0.0
    }
    
    //display concluded events
    func concludedAction(sender:Button!) {
        scrollButton.backgroundColor = UIColor.whiteColor()
        scrollButton.setTitleColor(darkRedColor, forState: UIControlState.Normal)
        scrollButton2.backgroundColor = darkRedColor
        scrollButton2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        scrollLabelBackground.backgroundColor = UIColor.whiteColor()
        scrollLabelBackground2.backgroundColor = darkRedColor
        self.view.addSubview(scrollLabelBackground)
        self.view.addSubview(scrollLabelBackground2)
        self.view.addSubview(scrollButton)
        self.view.addSubview(scrollButton2)
        scrollView.alpha = 0.0
        scrollView2.alpha = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //query for hosted events and place them in scrollview
    func updateHostedEvents(hostEventsName: String!) {
        let statusRef = dataBase.childByAppendingPath("/events/\(hostEventsName)/status")
        statusRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            let button = Button()
            let title = hostEventsName.componentsSeparatedByString("^")[0]
            button.titleLabel!.font = UIFont(name: "Menlo", size: 18*screenSize.width/320) //Chalkboard SE
            button.setTitle(title, forState: UIControlState.Normal)
            button.setTitleColor(self.lightWhiteColor, forState: UIControlState.Normal)
            button.string = hostEventsName
            button.frame = CGRectMake(0, 0, self.scrollView.frame.width*0.9, screenSize.height*0.09)
            button.frame.origin.x = (self.scrollView.frame.width - button.frame.width)*0.5
            button.layer.cornerRadius = 10
            button.addTarget(self, action: "eventAction:", forControlEvents: UIControlEvents.TouchUpInside)
            if let status = snapshot.value as? String {
            if status == "active" {
                let endTimeRef = dataBase.childByAppendingPath("events/" + hostEventsName + "/end time/")
                //check if concluded
                endTimeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                    let str = snapshot.value as? String
                    if str != nil {
                        let eventDate = dateFormatter.dateFromString(str!)
                        let date = NSDate()
                        let calendar = NSCalendar.currentCalendar()
                        var components = calendar.components(.Day, fromDate: date)
                        let day = components.day
                        components = calendar.components(.Month, fromDate: date)
                        let month = components.month
                        components = calendar.components(.Year, fromDate: date)
                        let year = components.year
                        components = calendar.components(.Hour, fromDate: date)
                        let hour = components.hour
                        components = calendar.components(.Minute, fromDate: date)
                        let min = components.minute
                        let timestamp: String = "\(day)-\(month)-\(year) \(hour):\(min)"
                        let currentDate = dateFormatter.dateFromString(timestamp)
                        if eventDate?.compare(currentDate!) == .OrderedAscending {
                            let localRef = dataBase.childByAppendingPath("/locations/\(hostEventsName)/")
                            localRef.removeValue()
                            statusRef.setValue("concluded")
                            if ((self.hostConcludedButtonCount + self.joinConcludedButtonCount) % 2 == 0) {
                                button.backgroundColor = self.lightWhiteColor
                                button.setTitleColor(self.normRedColor, forState: UIControlState.Normal)
                                
                            }
                            else if ((self.hostConcludedButtonCount + self.joinConcludedButtonCount) % 2 == 1) {
                                button.backgroundColor = self.dullRedColor//UIColor.whiteColor()
                            }
                            button.frame.origin.y = self.yPosConcluded
                            let yPosDiff = screenSize.height/60
                            self.yPosConcluded = self.yPosConcluded + button.frame.size.height + yPosDiff
                            self.hostConcludedButtonCount = self.hostConcludedButtonCount + 1
                            self.scrollView2.contentSize.height = 20 + 20 + CGFloat(self.hostConcludedButtonCount + self.joinConcludedButtonCount)*(button.frame.size.height + yPosDiff) - yPosDiff
                            self.scrollView2.addSubview(button)
                        }
                        else {
                            if ((self.hostButtonCount + self.joinButtonCount) % 2 == 0) {
                                button.backgroundColor = self.lightWhiteColor
                                button.setTitleColor(self.normRedColor, forState: UIControlState.Normal)
                            }
                            else if ((self.hostButtonCount + self.joinButtonCount) % 2 == 1) {
                                button.backgroundColor = self.dullRedColor//UIColor.whiteColor()
                            }
                            else if ((self.hostButtonCount + self.joinButtonCount) % 3 == 2) {
                                button.backgroundColor = self.lightOrangeColor//UIColor.whiteColor()
                            }
                            let yPosDiff = screenSize.height/60
                            button.frame.origin.y = self.yPos
                            self.yPos = self.yPos + button.frame.size.height + yPosDiff
                            self.hostButtonCount = self.hostButtonCount + 1
                            self.scrollView.contentSize.height = 20 + 20 + CGFloat(self.hostButtonCount + self.joinButtonCount)*(button.frame.size.height + yPosDiff) - yPosDiff
                            self.scrollView.addSubview(button)
                        }
                    }
                })
                let crown = UIButton()
                crown.frame = CGRectMake(0, 0, button.frame.size.width/10, button.frame.size.width/10)
                crown.frame.origin.x = button.frame.size.width*0.05
                crown.frame.origin.y = (button.frame.size.height - crown.frame.size.height)/2
                crown.setImage(UIImage(named: "crown.png"), forState: UIControlState.Normal)
                crown.userInteractionEnabled = false
                button.addSubview(crown)
            }
            else if status == "concluded" {
                if ((self.hostConcludedButtonCount + self.joinConcludedButtonCount) % 2 == 0) {
                    button.backgroundColor = self.lightWhiteColor
                    button.setTitleColor(self.normRedColor, forState: UIControlState.Normal)
                }
                else if ((self.hostConcludedButtonCount + self.joinConcludedButtonCount) % 2 == 1) {
                    button.backgroundColor = self.dullRedColor//UIColor.whiteColor()
                }
                else if ((self.hostConcludedButtonCount + self.joinConcludedButtonCount) % 3 == 2) {
                    button.backgroundColor = self.lightOrangeColor//UIColor.whiteColor()
                }
                button.frame.origin.y = self.yPosConcluded
                let yPosDiff = screenSize.height/60
                self.yPosConcluded = self.yPosConcluded + button.frame.size.height + yPosDiff
                self.hostConcludedButtonCount = self.hostConcludedButtonCount + 1
                self.scrollView2.contentSize.height = 20 + 20 + CGFloat(self.hostConcludedButtonCount + self.joinConcludedButtonCount)*(button.frame.size.height + yPosDiff) - yPosDiff
                self.scrollView2.addSubview(button)
                let crown = UIButton()
                crown.frame = CGRectMake(0, 0, button.frame.size.width/10, button.frame.size.width/10)
                crown.frame.origin.x = button.frame.size.width*0.05
                crown.frame.origin.y = (button.frame.size.height - crown.frame.size.height)/2
                crown.setImage(UIImage(named: "crown.png"), forState: UIControlState.Normal)
                button.addSubview(crown)
                refresh = 1
            }
            }
            else {
                let userEventRef = dataBase.childByAppendingPath("users/\(userID)/hosted events/\(hostEventsName)")
                userEventRef.removeValue()
            }
        })
    }
    
    //query for joined events and place them in scrollview
    func updateJoinedEvents(joinedEventsName: String!) {
        let statusRef = dataBase.childByAppendingPath("/events/\(joinedEventsName)/status")
        statusRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            let button = Button()
            let title = joinedEventsName.componentsSeparatedByString("^")[0]
            button.titleLabel!.font = UIFont(name: "Menlo", size: 18*screenSize.width/320) //Chalkboard SE
            button.setTitle(title, forState: UIControlState.Normal)
            button.setTitleColor(self.lightWhiteColor, forState: UIControlState.Normal)
            button.string = joinedEventsName
            button.frame = CGRectMake(0, 0, self.scrollView.frame.width*0.9, screenSize.height*0.09)
            button.frame.origin.x = (self.scrollView.frame.width - button.frame.width)*0.5
            button.layer.cornerRadius = 10
            button.addTarget(self, action: "eventAction:", forControlEvents: UIControlEvents.TouchUpInside)
            if let status = snapshot.value as? String {
            if status == "active" {
                let endTimeRef = dataBase.childByAppendingPath("events/" + joinedEventsName + "/end time/")
                //check if concluded
                endTimeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                    let str = snapshot.value as? String
                    if str != nil {
                        let eventDate = dateFormatter.dateFromString(str!)
                        let date = NSDate()
                        let calendar = NSCalendar.currentCalendar()
                        var components = calendar.components(.Day, fromDate: date)
                        let day = components.day
                        components = calendar.components(.Month, fromDate: date)
                        let month = components.month
                        components = calendar.components(.Year, fromDate: date)
                        let year = components.year
                        components = calendar.components(.Hour, fromDate: date)
                        let hour = components.hour
                        components = calendar.components(.Minute, fromDate: date)
                        let min = components.minute
                        let timestamp: String = "\(day)-\(month)-\(year) \(hour):\(min)"
                        let currentDate = dateFormatter.dateFromString(timestamp)
                        if eventDate?.compare(currentDate!) == .OrderedAscending {
                            let localRef = dataBase.childByAppendingPath("/locations/\(joinedEventsName)/")
                            localRef.removeValue()
                            statusRef.setValue("concluded")
                            if ((self.hostConcludedButtonCount + self.joinConcludedButtonCount) % 2 == 0) {
                                button.backgroundColor = self.lightWhiteColor
                                button.setTitleColor(self.normRedColor, forState: UIControlState.Normal)
                            }
                            else if ((self.hostConcludedButtonCount + self.joinConcludedButtonCount) % 2 == 1) {
                                button.backgroundColor = self.dullRedColor//UIColor.whiteColor()
                            }
                            button.frame.origin.y = self.yPosConcluded
                            let yPosDiff = screenSize.height/60
                            self.yPosConcluded = self.yPosConcluded + button.frame.size.height + yPosDiff
                            self.hostConcludedButtonCount = self.hostConcludedButtonCount + 1
                            self.scrollView2.contentSize.height = 20 + 20 + CGFloat(self.hostConcludedButtonCount + self.joinConcludedButtonCount)*(button.frame.size.height + yPosDiff) - yPosDiff
                            self.scrollView2.addSubview(button)
                        }
                        else {
                            if ((self.hostButtonCount + self.joinButtonCount) % 2 == 0) {
                                button.backgroundColor = self.lightWhiteColor
                                button.setTitleColor(self.normRedColor, forState: UIControlState.Normal)
                            }
                            else if ((self.hostButtonCount + self.joinButtonCount) % 2 == 1) {
                                button.backgroundColor = self.dullRedColor//UIColor.whiteColor()
                            }
                            else if ((self.hostButtonCount + self.joinButtonCount) % 3 == 2) {
                                button.backgroundColor = self.lightOrangeColor//UIColor.whiteColor()
                            }
                            let yPosDiff = screenSize.height/60
                            button.frame.origin.y = self.yPos
                            self.yPos = self.yPos + button.frame.size.height + yPosDiff
                            self.hostButtonCount = self.hostButtonCount + 1
                            self.scrollView.contentSize.height = 20 + 20 + CGFloat(self.hostButtonCount + self.joinButtonCount)*(button.frame.size.height + yPosDiff) - yPosDiff
                            self.scrollView.addSubview(button)
                        }
                    }
                })
            }
            else if status == "concluded" {
                if ((self.hostConcludedButtonCount + self.joinConcludedButtonCount) % 2 == 0) {
                    button.backgroundColor = self.lightWhiteColor
                    button.setTitleColor(self.normRedColor, forState: UIControlState.Normal)
                }
                else if ((self.hostConcludedButtonCount + self.joinConcludedButtonCount) % 2 == 1) {
                    button.backgroundColor = self.dullRedColor//UIColor.whiteColor()
                }
                else if ((self.hostConcludedButtonCount + self.joinConcludedButtonCount) % 3 == 2) {
                    button.backgroundColor = self.lightOrangeColor//UIColor.whiteColor()
                }
                button.frame.origin.y = self.yPosConcluded
                let yPosDiff = screenSize.height/60
                self.yPosConcluded = self.yPosConcluded + button.frame.size.height + yPosDiff
                self.hostConcludedButtonCount = self.hostConcludedButtonCount + 1
                self.scrollView2.contentSize.height = 20 + 20 + CGFloat(self.hostConcludedButtonCount + self.joinConcludedButtonCount)*(button.frame.size.height + yPosDiff) - yPosDiff
                self.scrollView2.addSubview(button)
                refresh = 1
            }
            }
            else {
                print("no ev")
                let userEventRef = dataBase.childByAppendingPath("users/\(userID)/joined events/\(joinedEventsName)")
                userEventRef.removeValue()
            }
            //statusRef.removeAllObservers()
            
        })
    }

}
