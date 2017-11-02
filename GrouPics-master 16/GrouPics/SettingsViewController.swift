//
//  SettingsViewController.swift
//  GrouPics
//
//  Created by Thomas Weng on 4/26/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// allows host to change event information

import UIKit

class SettingsViewController: UIViewController {
    
    var passwordView: UIViewController = UIViewController()
    var coverPhotoView: UIViewController = UIViewController()
    var timeView: UIViewController = UIViewController()
    
    // add buttons and titles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dullRedColor = UIColor(red: 193/255.0, green: 113/255.0, blue: 104/255.0, alpha: 1.0)

        passwordView = storyboard!.instantiateViewControllerWithIdentifier("editPasswordView") as UIViewController
        coverPhotoView = storyboard!.instantiateViewControllerWithIdentifier("editCoverPhotoView") as UIViewController
        timeView = storyboard!.instantiateViewControllerWithIdentifier("editTimeView") as UIViewController
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.whiteColor() //veryDullRedColor
        titleLabel.text = "Settings"
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont(name: "Menlo-Bold", size: 35*screenSize.width/375)
        titleLabel.frame = CGRectMake(0, 0, screenSize.width, screenSize.height * 0.15)
        titleLabel.frame.origin.x = (screenSize.width - titleLabel.frame.size.width)/2
        titleLabel.frame.origin.y = (screenSize.height - titleLabel.frame.size.height)*0.1
        titleLabel.alpha = 1.0
        self.view.addSubview(titleLabel)
        
        // Do any additional setup after loading the view.
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor(red: 215/255, green: 176/255, blue: 176/255, alpha: 1.0) //veryDullRedColor
        nameLabel.text = "Event Name: " + eventName.componentsSeparatedByString("^")[0]
        nameLabel.textAlignment = .Center
        //titleLabel.font = UIFont(name: "Menlo-Bold", size: 35*screenSize.width/375)
        nameLabel.font = UIFont(name: "Menlo-Bold", size: 20)
        nameLabel.frame = CGRectMake(0, 0, screenSize.width, screenSize.height * 0.15)
        nameLabel.frame.origin.x = (screenSize.width - nameLabel.frame.size.width)/2
        nameLabel.frame.origin.y = screenSize.height/5.1
        //titleLabel.frame.origin.y = (screenSize.height - titleLabel.frame.size.height)*0.1
        nameLabel.alpha = 1.0
        
        let diff = screenSize.height/30
        
        let description = UIButton()
        description.titleLabel!.font = UIFont(name: "Menlo", size: 16*screenSize.width/320)
        description.setTitle("Change Description", forState: UIControlState.Normal)
        description.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        description.backgroundColor = dullRedColor
        description.frame = CGRectMake(0, 0, screenSize.width * 0.7, screenSize.height * 0.1)
        description.frame.origin.x = (screenSize.width - description.frame.size.width)/2
        description.frame.origin.y = nameLabel.frame.origin.y + diff*4
        description.alpha = 1.0
        description.layer.cornerRadius = 10
        description.addTarget(self, action: #selector(SettingsViewController.descriptionAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        let photo = UIButton()
        photo.titleLabel!.font = UIFont(name: "Menlo", size: 16*screenSize.width/320)
        photo.setTitle("Change Cover Photo", forState: UIControlState.Normal)
        photo.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        photo.backgroundColor = dullRedColor
        photo.frame = CGRectMake(0, 0, screenSize.width * 0.7, screenSize.height * 0.1)
        photo.frame.origin.x = (screenSize.width - description.frame.size.width)/2
        photo.frame.origin.y = description.frame.origin.y + description.frame.size.height + diff
        photo.alpha = 1.0
        photo.layer.cornerRadius = 10
        photo.addTarget(self, action: #selector(SettingsViewController.photoAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        let endTime = UIButton()
        endTime.titleLabel!.font = UIFont(name: "Menlo", size: 16*screenSize.width/320)
        endTime.setTitle("Change End Time", forState: UIControlState.Normal)
        endTime.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        endTime.backgroundColor = dullRedColor
        endTime.frame = CGRectMake(0, 0, screenSize.width * 0.7, screenSize.height * 0.1)
        endTime.frame.origin.x = (screenSize.width - description.frame.size.width)/2
        endTime.frame.origin.y = photo.frame.origin.y + photo.frame.size.height + diff
        endTime.alpha = 1.0
        endTime.layer.cornerRadius = 10
        endTime.addTarget(self, action: #selector(SettingsViewController.timeAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        let password = UIButton()
        password.titleLabel!.font = UIFont(name: "Menlo", size: 16*screenSize.width/320)
        password.setTitle("Change Password", forState: UIControlState.Normal)
        password.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        password.backgroundColor = dullRedColor
        password.frame = CGRectMake(0, 0, screenSize.width * 0.7, screenSize.height * 0.1)
        password.frame.origin.x = (screenSize.width - description.frame.size.width)/2
        password.frame.origin.y = endTime.frame.origin.y + endTime.frame.size.height + diff
        password.alpha = 1.0
        password.layer.cornerRadius = 10
        
        password.addTarget(self, action: #selector(SettingsViewController.passwordAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(description)
        self.view.addSubview(photo)
        self.view.addSubview(endTime)
        self.view.addSubview(password)
        
        
    }
    
    // change description
    func descriptionAction(sender:UIButton!) {
        var des : String = String()
        let eventRef = dataBase.childByAppendingPath("events/" + eventName)
        let descriptionRef = eventRef.childByAppendingPath("description/")
        var newDescription: UITextField = UITextField()
        descriptionRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            des = snapshot.value as! String
            
            let actionSheetController: UIAlertController = UIAlertController(title: "Event Description", message: "Current: \(des)", preferredStyle: .Alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) {action -> Void in
            }
            actionSheetController.addAction(cancelAction)
            
            actionSheetController.addTextFieldWithConfigurationHandler{textField -> Void in
                //textField.textColor = UIColor.blueColor()
                //textField.placeholder = "password"
                textField.secureTextEntry = false
                textField.placeholder = "Change"
                newDescription = textField
            }
            
            let nextAction: UIAlertAction = UIAlertAction(title: "Save", style: .Default) {action -> Void in
                let tempRef = eventRef.childByAppendingPath("description/")
                tempRef.setValue(newDescription.text)
            }
            actionSheetController.addAction(nextAction)
            self.presentViewController(actionSheetController, animated: true, completion: nil)
            
        })
    }
    
    // take to page to change cover photo
    func photoAction(sender:UIButton!) {

        eventsNavController.pushViewController(coverPhotoView, animated: true)
    }
    
    // take to page to change end time
    func timeAction(sender:UIButton!) {

        eventsNavController.pushViewController(timeView, animated: true)
    }
    
    // take to page to change password
    func passwordAction(sender:UIButton!) {
        eventsNavController.pushViewController(passwordView, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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