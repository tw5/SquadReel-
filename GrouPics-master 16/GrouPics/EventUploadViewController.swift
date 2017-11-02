//
//  EventUploadViewController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 3/29/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// allows users to upload from phones photo library

import UIKit
import Firebase

class EventUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    let img: UIImageView = UIImageView()
    
    //obtain image selected
    override func viewDidAppear(animated: Bool) {
        img.image = tempImg
        img.frame.size.height = screenSize.width * (img.image!.size.height/img.image!.size.width)
        img.frame.origin.y = (screenSize.height - img.frame.size.height)/2
    }
    
    // display image on full screen, allow upload or select again
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for v in self.view.subviews {
            v.removeFromSuperview()
        }
        img.image = tempImg
        img.frame.size.width = screenSize.width
        img.frame.size.height = screenSize.width * (img.image!.size.height/img.image!.size.width)
        img.frame.origin.x = (screenSize.width - img.frame.size.width)/2
        img.frame.origin.y = (screenSize.height - img.frame.size.height)/2
        self.view.addSubview(img)
        self.navigationController?.navigationBarHidden = true
        UIApplication.sharedApplication().statusBarHidden = true
        tabBarController?.tabBar.hidden = true
        let circle : UIImage? = UIImage(named:"circle")
        
        let buttonLabel: UILabel = UILabel()
        let darkGray = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
        buttonLabel.backgroundColor = darkGray
        buttonLabel.frame = CGRectMake(0, 0, screenSize.width, screenSize.height * 0.11)
        buttonLabel.frame.origin.x = (screenSize.width - buttonLabel.frame.size.width)/2
        buttonLabel.frame.origin.y = (screenSize.height)*0.89
        buttonLabel.alpha = 1.0
        self.view.addSubview(buttonLabel)
        
        //upload button
        let upl = UIButton(type: UIButtonType.System) as UIButton
        upl.titleLabel!.font = UIFont(name: "Menlo", size: 18)
        upl.frame = CGRectMake(0, 0, screenSize.width * 0.3, screenSize.height * 0.05)
        upl.frame.origin.x = (screenSize.width - upl.frame.size.width)*0.95
        upl.frame.origin.y = buttonLabel.frame.origin.y + (buttonLabel.frame.size.height - upl.frame.size.height)*0.5
        upl.setTitle("Use Photo", forState: UIControlState.Normal)
        upl.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        upl.addTarget(self, action: "uploadAction:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(upl)
        
        //reselect button
        let reselect = UIButton(type: UIButtonType.System) as UIButton
        reselect.titleLabel!.font = UIFont(name: "Menlo", size: 16)
        reselect.frame = CGRectMake(0, 0, screenSize.width * 0.35, screenSize.height * 0.05)
        reselect.frame.origin.x = (screenSize.width - reselect.frame.size.width)*0.05
        reselect.frame.origin.y = buttonLabel.frame.origin.y + (buttonLabel.frame.size.height - upl.frame.size.height)*0.5
        reselect.setTitle("Choose Again", forState: UIControlState.Normal)
        reselect.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        reselect.addTarget(self, action: "reselectAction:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(reselect)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //upload pic
    func uploadAction(sender:UIButton!) {
        self.navigationController?.navigationBarHidden = true
        tabBarController?.tabBar.hidden = false
        UIApplication.sharedApplication().statusBarHidden = false
        self.navigationController?.popToRootViewControllerAnimated(false)
        eventsNavLocal = 1
        //refresh = 1
        let eventRef = dataBase.childByAppendingPath("events/" + eventName)
        let countRef = eventRef.childByAppendingPath("picture count/")
        countRef.runTransactionBlock({
            (currentData:FMutableData!) in
            var value = currentData.value as? Int
            if (value == nil) {
                value = 0
            }
            currentData.value = value! + 1
            return FTransactionResult.successWithValue(currentData)
        })
        let indexRef = eventRef.childByAppendingPath("picture index/")
        indexRef.runTransactionBlock({
            (currentData:FMutableData!) in
            var value = currentData.value as? Int
            if (value == nil) {
                value = 0
            }
            else {
                if self.img.image != nil {
                    let imgData = UIImageJPEGRepresentation(self.img.image!, 0.0)!
                    let pictureInput = imgData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
                    let tempRef = eventRef.childByAppendingPath("pictures/\(value!)")
                    tempRef.setValue(pictureInput)
//                    let endRef = eventRef.childByAppendingPath("pictures/\(value! + 1)")
//                    endRef.setValue("end")
                    let tempRef2 = eventRef.childByAppendingPath("picture owners/\(value!)")
                    tempRef2.setValue(userID)
                }
            }
            currentData.value = value! + 1
            return FTransactionResult.successWithValue(currentData)
        })
    }
    
    //reopen image picker
    func reselectAction(sender:UIButton!) {
        var pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
        self.img.image = nil
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var chosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        self.dismissViewControllerAnimated(true, completion: nil)
        tempImg = chosenImage
        img.image = chosenImage
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
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
