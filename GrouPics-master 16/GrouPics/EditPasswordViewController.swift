//
//  SetPasswordViewController.swift
//  GrouPics
//
//  Created by Thomas Weng on 4/28/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// allows host to change password

import UIKit
class EditPasswordViewController: UIViewController {
    let mySwitch = UISwitch() as UISwitch
    let pw = UITextField() as UITextField
    let pw2 = UITextField() as UITextField
    
    // add buttons and text inputs
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let dullRedColor = UIColor(red: 193/255.0, green: 113/255.0, blue: 104/255.0, alpha: 1.0)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.whiteColor() //veryDullRedColor
        titleLabel.text = "Change event password?"
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont(name: "Menlo-Bold", size: 25*screenSize.width/375)
        titleLabel.frame = CGRectMake(0, 0, screenSize.width, screenSize.height * 0.3)
        titleLabel.frame.origin.x = (screenSize.width - titleLabel.frame.size.width)/2
        titleLabel.frame.origin.y = (screenSize.height - titleLabel.frame.size.height)*0.1
        titleLabel.alpha = 1.0
        self.view.addSubview(titleLabel)
        
        let save = UIButton()
        save.titleLabel!.font = UIFont(name: "Menlo", size: 16*screenSize.width/320)
        save.setTitle("Save", forState: UIControlState.Normal)
        save.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        save.backgroundColor = dullRedColor
        save.frame = CGRectMake(0, 0, screenSize.width * 0.4, screenSize.height * 0.1)
        save.frame.origin.x = (screenSize.width - save.frame.size.width)/2
        save.frame.origin.y = screenSize.height*0.7
        save.alpha = 1.0
        save.layer.cornerRadius = 10
        save.addTarget(self, action: "saveAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(save)
        
        mySwitch.frame = CGRectMake(0, 0, screenSize.width * 0.3, screenSize.height * 0.09)
        mySwitch.frame.origin.x = (screenSize.width - mySwitch.frame.size.width)/2
        mySwitch.frame.origin.y = (screenSize.height - mySwitch.frame.size.height)*0.35
        mySwitch.tintColor = UIColor.redColor()//(red: 71/255, green: 153/255, blue: 255/255, alpha: 1.0)
        mySwitch.onTintColor = dullRedColor
        mySwitch.on = false
        self.view.addSubview(mySwitch)
        
        pw.placeholder = " Password"
        pw.frame = CGRectMake(0, 0, screenSize.width * 0.7, screenSize.height * 0.05)
        pw.frame.origin.x = (screenSize.width - pw.frame.size.width)/2
        pw.frame.origin.y = mySwitch.frame.origin.y + screenSize.height*0.085
        pw.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        let borderColor = UIColor(red: 204.0/255.0, green:204.0/255.0, blue:204.0/255.0, alpha:1.0)
        pw.layer.borderColor = borderColor.CGColor;
        pw.layer.borderWidth = 1.0;
        pw.layer.cornerRadius = 5.0;
        pw.userInteractionEnabled = false
        pw.backgroundColor = UIColor.clearColor()
        pw.autocapitalizationType = .None
        pw.autocorrectionType = .No
        pw.spellCheckingType = .No
        pw.secureTextEntry = true
        
        pw2.placeholder = " Confirm Password"
        pw2.frame = CGRectMake(0, 0, screenSize.width * 0.7, screenSize.height * 0.05)
        pw2.frame.origin.x = (screenSize.width - pw.frame.size.width)/2
        pw2.frame.origin.y = mySwitch.frame.origin.y + screenSize.height*0.085 + pw.frame.size.height + screenSize.height/19
        pw2.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        pw2.layer.borderColor = borderColor.CGColor;
        pw2.layer.borderWidth = 1.0;
        pw2.layer.cornerRadius = 5.0;
        pw2.userInteractionEnabled = false
        pw2.backgroundColor = UIColor.clearColor()
        pw2.autocapitalizationType = .None
        pw2.autocorrectionType = .No
        pw2.spellCheckingType = .No
        pw2.secureTextEntry = true
        self.view.addSubview(pw)
        self.view.addSubview(pw2)
        
        mySwitch.addTarget(self, action: "switchChanged:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    //select or de-select password
    func switchChanged(sender:UISwitch!) {
        if mySwitch.on {
            pw.userInteractionEnabled = true
            pw.backgroundColor = UIColor.whiteColor()
            pw2.userInteractionEnabled = true
            pw2.backgroundColor = UIColor.whiteColor()
        }
        else {
            pw.userInteractionEnabled = false
            pw.backgroundColor = UIColor.clearColor()
            pw.text = ""
            pw2.userInteractionEnabled = false
            pw2.backgroundColor = UIColor.clearColor()
            pw2.text = ""
        }
    }
    
    // save new password
    func saveAction(sender:UIButton!) {
        if (mySwitch.on && pw.text! == "") {
            let alert = UIAlertView()
            alert.title = "Wait a Sec"
            alert.message = "Please enter a Password or turn off Password protection"
            alert.addButtonWithTitle("Understood")
            alert.show()
        }
        else if (mySwitch.on && pw.text! != pw2.text!)
        {
            let alert = UIAlertView()
            alert.title = "Try Again"
            alert.message = "Make sure the your confirmed Password matches"
            alert.addButtonWithTitle("Understood")
            alert.show()
        }
        else if (!mySwitch.on)
        {
            eventsNavController.popViewControllerAnimated(true)
            let eventRef = dataBase.childByAppendingPath("events/" + eventName)
            var tempRef = eventRef.childByAppendingPath("password/")
            tempRef.setValue("")
        }
        else
        {
            eventsNavController.popViewControllerAnimated(true)
            var newPassword : String = String()
            let eventRef = dataBase.childByAppendingPath("events/" + eventName)
            newPassword = pw.text!
            var tempRef = eventRef.childByAppendingPath("password/")
            tempRef.setValue(newPassword)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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