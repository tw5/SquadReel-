//
//  Create3ViewController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 3/28/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// obtain event password

import UIKit

var passwordInput : String = String()

class Create4ViewController: UIViewController {
    
    let pw = UITextField() as UITextField
    let pw2 = UITextField() as UITextField
    let mySwitch = UISwitch() as UISwitch
    let buttonImg = UIImageView()
    //@IBOutlet weak var mySwitch: UISwitch!
    
    override func viewDidLoad() {
        //create switches and buttons
        super.viewDidLoad()
        mySwitch.frame = CGRectMake(0, 0, screenSize.width * 0.3, screenSize.height * 0.09)
        mySwitch.frame.origin.x = (screenSize.width - mySwitch.frame.size.width)/2
        mySwitch.frame.origin.y = (screenSize.height - mySwitch.frame.size.height)*0.5
        mySwitch.tintColor = UIColor(red: 71/255, green: 153/255, blue: 255/255, alpha: 1.0)
        mySwitch.onTintColor = UIColor(red: 46/255, green: 106/255, blue: 202/255, alpha: 1.0)
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
        pw2.frame.origin.y = mySwitch.frame.origin.y + screenSize.height*0.085 + pw.frame.size.height + screenSize.height/25
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
        
        // Do any additional setup after loading the view.
        
        let tv = UITextView()
        tv.frame = CGRectMake(0, 0, screenSize.width*0.85, screenSize.height * 0.15)
        tv.frame.origin.x = (screenSize.width - tv.frame.size.width)/2
        tv.frame.origin.y = (screenSize.height - tv.frame.size.height)*0.36
        
        tv.backgroundColor = UIColor.clearColor()
        let sampleText = "Allow only certain guests and individuals to join your GrouPics Event by enabling password protection."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        let attributedString = NSAttributedString(string: sampleText,
                                                  attributes: [
                                                    NSParagraphStyleAttributeName: paragraphStyle,
                                                    NSBaselineOffsetAttributeName: NSNumber(float: 0)
            ])
        
        tv.attributedText = attributedString
        tv.font = UIFont(name: "Arial", size: 15*screenSize.width/375)
        tv.userInteractionEnabled = false
        self.view.addSubview(tv)
        
        let circle : UIImage? = UIImage(named:"circle")
        let next   = UIButton(type: UIButtonType.System) as UIButton
        next.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 21*screenSize.width/375)
        next.frame = CGRectMake(0, 0, screenSize.width * 0.3, screenSize.height * 0.09)
        next.frame.origin.x = (screenSize.width - next.frame.size.width)/2
        next.frame.origin.y = (screenSize.height - next.frame.size.height)*0.82
        next.setTitle("Next", forState: UIControlState.Normal)
        let blueColor = UIColor(red: 136/255, green: 175/255, blue: 239/255, alpha: 1.0)
        let lightBlueColor = UIColor(red: 50/255, green: 70/255, blue: 147/255, alpha: 1.0)
        next.setTitleColor(lightBlueColor, forState: UIControlState.Normal)
        next.addTarget(self, action: #selector(Create3ViewController.nextAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        next.addTarget(self, action: #selector(CreateViewController.clickAction(_:)), forControlEvents: UIControlEvents.TouchDown)
        next.addTarget(self, action: #selector(CreateViewController.dragAction(_:)), forControlEvents: UIControlEvents.TouchDragExit)
        buttonImg.frame = CGRectMake(0, 0, next.frame.size.width/1.3, next.frame.size.width/1.6)
        buttonImg.frame.origin.x = (screenSize.width - buttonImg.frame.size.width)/1.95
        buttonImg.frame.origin.y = (next.frame.origin.y + screenSize.height/42)
        buttonImg.image = UIImage(named: "arrow")
        
        self.view.addSubview(buttonImg)
        self.view.addSubview(next)
        
        mySwitch.addTarget(self, action: "switchChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // turn password on and off
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
    
    // when user clicks next, obtain optional password
    func nextAction(sender:UIButton!) {
        buttonImg.alpha = 1.0
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
            
        else {
            var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var v: UIViewController = storyboard.instantiateViewControllerWithIdentifier("createView5") as UIViewController
            createNavController.pushViewController(v, animated: true)
            passwordInput = pw.text!
        }
    }
    
    
    
    func clickAction(sender:UIButton!) {
        buttonImg.alpha = 0.1
    }
    
    func dragAction(sender:UIButton!) {
        buttonImg.alpha = 1.0
    }
    
}
