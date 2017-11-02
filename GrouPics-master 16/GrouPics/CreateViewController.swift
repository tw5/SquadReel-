//
//  CreateViewController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 3/27/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// obtain event name and description

import UIKit

var nameInput: String = String()
var descriptionInput: String = String()
var allowClick: Bool = true

class CreateViewController: UIViewController {

    let circle : UIImage? = UIImage(named:"circle")
    let buttonImg = UIImageView()
    @IBOutlet weak var next: UIButton!
    var name: UITextView!
    var descrip: UITextView!
    
    var backgroundColors = [UIColor()]
    var backgroundLoop = 0
    var v: UIViewController = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        v = storyboard!.instantiateViewControllerWithIdentifier("createView2") as UIViewController
        // Do any additional setup after loading the view.
        
        // Create buttons and titles 
        
        let next   = UIButton(type: UIButtonType.System) as UIButton
        next.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 21*screenSize.width/375)
        next.frame = CGRectMake(0, 0, screenSize.width * 0.3, screenSize.height * 0.09)
        next.frame.origin.x = (screenSize.width - next.frame.size.width)/2
        next.frame.origin.y = (screenSize.height - next.frame.size.height)*0.82
        next.setTitle("Next", forState: UIControlState.Normal)
        let blueColor = UIColor(red: 136/255, green: 175/255, blue: 239/255, alpha: 1.0)
        let darkBlueColor = UIColor(red: 0/255, green: 48/255, blue: 92/255, alpha: 1.0)
        let lightBlueColor = UIColor(red: 50/255, green: 70/255, blue: 147/255, alpha: 1.0)
        next.setTitleColor(lightBlueColor, forState: UIControlState.Normal)
        let arrow : UIImage? = UIImage(named:"arrow")
        next.addTarget(self, action: #selector(CreateViewController.nextAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        next.addTarget(self, action: #selector(CreateViewController.clickAction(_:)), forControlEvents: UIControlEvents.TouchDown)
        next.addTarget(self, action: #selector(CreateViewController.dragAction(_:)), forControlEvents: UIControlEvents.TouchDragExit)
        buttonImg.frame = CGRectMake(0, 0, next.frame.size.width/1.3, next.frame.size.width/1.6)
        buttonImg.frame.origin.x = (screenSize.width - buttonImg.frame.size.width)/1.95
        buttonImg.frame.origin.y = (next.frame.origin.y + screenSize.height/42)
        //let grayColor = UIColor(red: 137/255, green: 140/255, blue: 145/255, alpha: 1.0)
        buttonImg.image = UIImage(named: "arrow")
        self.view.addSubview(next)
        self.view.addSubview(buttonImg)
        
        let borderColor = UIColor(red: 204.0/255.0, green:204.0/255.0, blue:204.0/255.0, alpha:1.0)
        
        name = UITextView()
        name.frame = CGRectMake(0, 0, screenSize.width * 0.7, screenSize.height * 0.06)
        name.frame.origin.x = (screenSize.width - name.frame.size.width)/2
        name.frame.origin.y = (screenSize.height - name.frame.size.height)*0.31
        name.layer.borderColor = borderColor.CGColor
        name.layer.borderWidth = 0.8
        name.layer.cornerRadius = 5.0
        name.autocorrectionType = .No
        self.view.addSubview(name)
        
        let nameLabelBackground = UILabel()
        nameLabelBackground.backgroundColor = darkBlueColor
        nameLabelBackground.frame = CGRectMake(0, 0, name.frame.size.width, screenSize.height * 0.03)
        nameLabelBackground.frame.origin.x = (screenSize.width  - nameLabelBackground.frame.size.width)/2
        nameLabelBackground.frame.origin.y = name.frame.origin.y - nameLabelBackground.frame.size.height
        self.view.addSubview(nameLabelBackground)
        
        let nameLabel = UILabel()
        nameLabel.text = "name"
        nameLabel.backgroundColor = darkBlueColor
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.textAlignment = .Center
        nameLabel.font = UIFont(name: "Menlo", size: 16*screenSize.width/320)
        nameLabel.frame = CGRectMake(0, 0, name.frame.size.width, screenSize.height * 0.05)
        nameLabel.frame.origin.x = (screenSize.width  - nameLabel.frame.size.width)/2
        nameLabel.frame.origin.y = name.frame.origin.y - nameLabel.frame.size.height
        nameLabel.clipsToBounds = true
        nameLabel.layer.cornerRadius = 10
        self.view.addSubview(nameLabel)
        
        descrip = UITextView()
        descrip.frame = CGRectMake(0, 0, screenSize.width * 0.7, screenSize.height * 0.24)
        descrip.frame.origin.x = (screenSize.width - descrip.frame.size.width)/2
        descrip.frame.origin.y = (screenSize.height - descrip.frame.size.height)*0.59
        descrip.layer.borderColor = borderColor.CGColor;
        descrip.layer.borderWidth = 0.8;
        descrip.layer.cornerRadius = 5.0;
        self.view.addSubview(descrip)
        
        let descripLabelBackground = UILabel()
        descripLabelBackground.backgroundColor = darkBlueColor
        descripLabelBackground.frame = CGRectMake(0, 0, descrip.frame.size.width, screenSize.height * 0.03)
        descripLabelBackground.frame.origin.x = (screenSize.width  - descripLabelBackground.frame.size.width)/2
        descripLabelBackground.frame.origin.y = descrip.frame.origin.y - descripLabelBackground.frame.size.height
        self.view.addSubview(descripLabelBackground)
        
        let descripLabel = UILabel()
        descripLabel.text = "description"
        descripLabel.backgroundColor = darkBlueColor
        descripLabel.textColor = UIColor.whiteColor()
        descripLabel.textAlignment = .Center
        descripLabel.font = UIFont(name: "Menlo", size: 16*screenSize.width/320)
        descripLabel.frame = CGRectMake(0, 0, descrip.frame.size.width, screenSize.height * 0.05)
        descripLabel.frame.origin.x = (screenSize.width  - descripLabel.frame.size.width)/2
        descripLabel.frame.origin.y = descrip.frame.origin.y - descripLabel.frame.size.height
        descripLabel.clipsToBounds = true
        descripLabel.layer.cornerRadius = 10
        self.view.addSubview(descripLabel)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        let lightBlue = UIColor(red: 178/255, green: 202/255, blue: 207/255, alpha: 1.0) // light blue
        let veryLightBlue = UIColor(red: 220/255, green: 233/255, blue: 236/255, alpha: 1.0) // light blue
        let blue = UIColor(red: 192/255, green: 215/255, blue: 220/255, alpha: 1.0)
        let purple = UIColor(red: 192/255, green: 194/255, blue: 220/255, alpha: 1.0)
        let color2 = UIColor(red: 169/255, green: 205/255, blue: 169/255, alpha: 1.0) // light green
        let color3 = UIColor(red: 200/255, green: 157/255, blue: 125/255, alpha: 1.0) // light orange
        backgroundColors = [blue, purple]
        backgroundLoop = 0
        //self.animateBackgroundColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    func animateBackgroundColor () {
        if backgroundLoop < backgroundColors.count - 1 {
            backgroundLoop++
        } else {
            backgroundLoop = 0
        }
        UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.view.backgroundColor =  self.backgroundColors[self.backgroundLoop];
        }) {(Bool) -> Void in
            self.animateBackgroundColor();
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // when user clicks next, check fields and proceed
    func nextAction(sender:UIButton!) {
        buttonImg.alpha = 1.0
        if (name.text! == "") {
                let alert = UIAlertView()
                alert.title = "Wait a Sec"
                alert.message = "Please enter an Event Name"
                alert.addButtonWithTitle("Understood")
                alert.show()
        }
        else if (name.text!.characters.count >= 15) {
            let alert = UIAlertView()
            alert.title = "Wait a Sec"
            alert.message = "Event Name must be under 15 characters"
            alert.addButtonWithTitle("Understood")
            alert.show()
        }
        else if allowClick {
            allowClick = false
            let nameReference = name.text!.lowercaseString + "^" + userID
            let eventsRef = dataBase.childByAppendingPath("events/")
            eventsRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                if snapshot.hasChild("/\(nameReference)") {
                    let alert = UIAlertView()
                    alert.title = "Wait a Sec"
                    alert.message = "You already created an event of this name"
                    alert.addButtonWithTitle("Understood")
                    alert.show()
                }
                else {
                    let n = self.name.text!
                    let d = self.descrip.text!
                    createNavController.pushViewController(self.v, animated: true)
                    nameInput = n
                    descriptionInput = d
                }
            })
        }
    }
    
    func clickAction(sender:UIButton!) {
        buttonImg.alpha = 0.1
    }
    
    func dragAction(sender:UIButton!) {
        buttonImg.alpha = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
