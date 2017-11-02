//
//  Create4ViewController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 3/28/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// obtain cover photo and obtain event

import UIKit
import Firebase
import GeoFire
import CoreLocation

var lastHostedEvent: String = String()

class Create5ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var img : UIImageView = UIImageView()
    let buttonImg = UIImageView()
    var v: UIViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        v = storyboard!.instantiateViewControllerWithIdentifier("createView1") as UIViewController
       
        // create buttons titles and photo
        let selPhoto = UIButton(type: UIButtonType.System) as UIButton
        selPhoto.setBackgroundImage(UIImage(named: "gallery.png"), forState: UIControlState.Normal)
        selPhoto.frame = CGRectMake(0, 0, screenSize.width * 0.1, screenSize.width * 0.08)
        selPhoto.frame.origin.x = (screenSize.width - selPhoto.frame.size.width)*0.21
        selPhoto.frame.origin.y = (screenSize.height - selPhoto.frame.size.height)*0.47
        selPhoto.addTarget(self, action: "selectPhoto:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(selPhoto)
        
        let takePhoto = UIButton(type: UIButtonType.System) as UIButton
        takePhoto.setBackgroundImage(UIImage(named: "album.png"), forState: UIControlState.Normal)
        takePhoto.frame = CGRectMake(0, 0, screenSize.width * 0.1, screenSize.width * 0.1)
        takePhoto.frame.origin.x = (screenSize.width - takePhoto.frame.size.width)*0.21
        takePhoto.frame.origin.y = selPhoto.frame.origin.y + screenSize.height/15
        takePhoto.addTarget(self, action: "takePhoto:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(takePhoto)
        
        // Do any additional setup after loading the view.
        let circle : UIImage? = UIImage(named:"circle")
        let create   = UIButton(type: UIButtonType.System) as UIButton
        create.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 21*screenSize.width/375)
        create.frame = CGRectMake(0, 0, screenSize.width * 0.5, screenSize.height * 0.14)
        create.frame.origin.x = (screenSize.width - create.frame.size.width)/2
        create.frame.origin.y = (screenSize.height - create.frame.size.height)*0.84
        create.setTitle("Create Event!", forState: UIControlState.Normal)
        let blueColor = UIColor(red: 136/255, green: 175/255, blue: 239/255, alpha: 1.0)
        let lightBlueColor = UIColor(red: 50/255, green: 70/255, blue: 147/255, alpha: 1.0)
        create.setTitleColor(lightBlueColor, forState: UIControlState.Normal)
        //create.setBackgroundImage(circle, forState: UIControlState.Normal)
        create.addTarget(self, action: "createAction:", forControlEvents:UIControlEvents.TouchUpInside)
        create.addTarget(self, action: #selector(CreateViewController.clickAction(_:)), forControlEvents: UIControlEvents.TouchDown)
        create.addTarget(self, action: #selector(CreateViewController.dragAction(_:)), forControlEvents: UIControlEvents.TouchDragExit)
        buttonImg.frame = CGRectMake(0, 0, create.frame.size.width*1.23, create.frame.size.width*0.80)
        buttonImg.frame.origin.x = (screenSize.width - buttonImg.frame.size.width)/1.9
        buttonImg.frame.origin.y = (create.frame.origin.y - screenSize.height/100)
        buttonImg.image = UIImage(named: "longarrow")
        self.view.addSubview(buttonImg)

        self.view.addSubview(create)
        
        img = UIImageView()
        img.frame = CGRectMake(0, 0, screenSize.width * 0.35, screenSize.height * 0.32)
        img.frame.origin.x = (screenSize.width - img.frame.size.width)*0.8
        img.frame.origin.y = (screenSize.height - img.frame.size.height)*0.5
        //let grayColor = UIColor(red: 137/255, green: 140/255, blue: 145/255, alpha: 1.0)
        let grayColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 0.5)
        img.backgroundColor = grayColor
        self.view.addSubview(img)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // when user clicks create, send all create info to the database
    func createAction(sender:UIButton!) {
        buttonImg.alpha = 1.0
        createNavController.pushViewController(v, animated: false)
        let nameReference = nameInput.lowercaseString + "^" + userID
        let eventRef = dataBase.childByAppendingPath("events/" + nameReference)
        var tempRef = eventRef.childByAppendingPath("name/")
        tempRef.setValue(nameInput.lowercaseString)
        tempRef = eventRef.childByAppendingPath("description/")
        tempRef.setValue(descriptionInput)
        tempRef = eventRef.childByAppendingPath("end time/")
        tempRef.setValue(dateInput)
        tempRef = eventRef.childByAppendingPath("password/")
        tempRef.setValue(passwordInput)
        tempRef = eventRef.childByAppendingPath("picture count/")
        tempRef.setValue(0)
        tempRef = eventRef.childByAppendingPath("picture index/")
        tempRef.setValue(0)
        tempRef = eventRef.childByAppendingPath("status/")
        tempRef.setValue("active")
        tempRef = eventRef.childByAppendingPath("host/")
        tempRef.setValue(userID)
        if img.image != nil {
            let imgData = UIImageJPEGRepresentation(img.image!, 0.0)!
            let pictureInput = imgData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            tempRef = eventRef.childByAppendingPath("cover photo/")
            tempRef.setValue(pictureInput)
        }
        else {
            tempRef = eventRef.childByAppendingPath("cover photo/")
            tempRef.setValue("")
        }
        let usersRef = dataBase.childByAppendingPath("users/" + userID + "/hosted events/" + nameReference)
        usersRef.setValue(nameReference)
        lastHostedEvent = nameReference
        eventName = nameInput.lowercaseString
        //temp = 1
        tabBarController!.selectedIndex = 2
        
        let locationRef = dataBase.childByAppendingPath("locations/")
        let geoFire = GeoFire(firebaseRef: locationRef)
        geoFire.setLocation(CLLocation(latitude: latitudeInput, longitude: longitudeInput), forKey: nameReference)

    }
    
    func clickAction(sender:UIButton!) {
        buttonImg.alpha = 0.1
    }
    
    func dragAction(sender:UIButton!) {
        buttonImg.alpha = 1.0
    }
    
    //allow user to pick photo from library
    @IBAction func selectPhoto(sender: AnyObject) {
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    // allow user to take photo
    @IBAction func takePhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(pickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let tempImg = info[UIImagePickerControllerOriginalImage] as? UIImage
        img.image = tempImg
        img.frame.size.height = screenSize.width * 0.32 * (tempImg!.size.height/tempImg!.size.width)
        img.frame.origin.y = (screenSize.height - img.frame.size.height)*0.5
        self.dismissViewControllerAnimated(true, completion: nil)
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
