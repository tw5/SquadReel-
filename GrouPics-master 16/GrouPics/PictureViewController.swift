//
//  PictureViewController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 4/10/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// full screen view of pictures in events

import UIKit
import Firebase
import AssetsLibrary

class PictureViewController: UIViewController {

    let img: UIImageView = UIImageView()
    var hidden: Bool = true
    let delete = UIButton(type: UIButtonType.System) as UIButton
    let save = UIButton(type: UIButtonType.System) as UIButton
    var deleteBarButtonItem:UIBarButtonItem = UIBarButtonItem()
    var saveBarButtonItem:UIBarButtonItem = UIBarButtonItem()
    
    override func viewDidDisappear(animated: Bool) {
        img.image = nil
    }
    // determine if owner of picture or event host
    override func viewDidAppear(animated: Bool) {
        hidden = true
        UIApplication.sharedApplication().statusBarHidden = true
        self.navigationController?.navigationBar.alpha = 0.0
        
        let eventRef = dataBase.childByAppendingPath("events/" + eventName)
        let hostRef = eventRef.childByAppendingPath("host/")
        self.deleteBarButtonItem.customView = delete
        hostRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            let host = snapshot.value as! String
            if host != userID {
                let pictureOwnerRef = eventRef.childByAppendingPath("picture owners/\(currentPictureValue!)")
                pictureOwnerRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                    let owner = snapshot.value as! String
                    print("owner: \(owner)")
                    if owner != userID {
                        self.deleteBarButtonItem.customView = UIButton()
                    }
                })
            }
        })
    }
    // add buttons and image
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(img)
        
        let screenButton   = UIButton(type: UIButtonType.System) as UIButton
        screenButton.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
        screenButton.frame.origin.x = (screenSize.width - screenButton.frame.size.width)/2
        screenButton.frame.origin.y = (screenSize.height - screenButton.frame.size.height)/2
        screenButton.addTarget(self, action: "screenButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(screenButton)
        
        if hidden {
            UIApplication.sharedApplication().statusBarHidden = true
            self.navigationController?.navigationBar.alpha = 0.0
        }
        else {
            UIApplication.sharedApplication().statusBarHidden = false
            self.navigationController?.navigationBar.alpha = 1.0
        }
        
        delete.setBackgroundImage(UIImage(named: "grayX.png"), forState: UIControlState.Normal)
        delete.frame.size.width = (self.navigationController?.navigationBar.frame.size.width)!/14
        delete.frame.size.height = delete.frame.size.width
        delete.frame.origin.x = ((self.navigationController?.navigationBar.frame.size.width)! - delete.frame.size.width) * 0.9
        delete.frame.origin.y = ((self.navigationController?.navigationBar.frame.size.height)! - delete.frame.size.height)/2
        delete.addTarget(self, action: "deletePhoto:", forControlEvents:UIControlEvents.TouchUpInside)
        delete.alpha = 0.0
        
        save.setBackgroundImage(UIImage(named: "save.png"), forState: UIControlState.Normal)
        save.frame.size.width = (self.navigationController?.navigationBar.frame.size.width)!/14
        save.frame.size.height = delete.frame.size.width
        save.frame.origin.x = ((self.navigationController?.navigationBar.frame.size.width)! - save.frame.size.width) * 0.9
        save.frame.origin.y = ((self.navigationController?.navigationBar.frame.size.height)! - save.frame.size.height)/2
        save.addTarget(self, action: "savePhoto:", forControlEvents:UIControlEvents.TouchUpInside)
        save.alpha = 0.0
        
        deleteBarButtonItem.customView = delete
        let space = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        space.width = (self.navigationController?.navigationBar.frame.size.width)!/20
        saveBarButtonItem.customView = save
        
        self.navigationItem.setRightBarButtonItems([saveBarButtonItem, space, deleteBarButtonItem], animated: true)
        //pself.navigationItem.setRightBarButtonItems([saveBarButtonItem, space, space, space, space, space, space, space, deleteBarButtonItem], animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        tabBarController!.tabBar.hidden = true
    }
    
    // saves photo to phone
    func savePhoto(sender:UIButton!) {
         UIImageWriteToSavedPhotosAlbum(img.image!, nil, nil, nil)
    }
    
    // allow host or picture owner to delete
    func deletePhoto(sender:UIButton!) {
        let tempRef = dataBase.childByAppendingPath("events/" + eventName + "/pictures/\(currentPictureValue)")
        //tempRef.setValue("")
        tempRef.removeValue()
        let tempRef2 = dataBase.childByAppendingPath("events/" + eventName + "/picture owners/\(currentPictureValue)")
        //tempRef2.setValue("")
        tempRef2.removeValue()
        let eventRef = dataBase.childByAppendingPath("events/" + eventName)
        let countRef = eventRef.childByAppendingPath("picture count/")
        countRef.runTransactionBlock({
            (currentData:FMutableData!) in
            var value = currentData.value as? Int
            if (value == nil) {
                value = 0
            }
            currentData.value = value! - 1
            return FTransactionResult.successWithValue(currentData)
        })
        self.navigationController?.popToRootViewControllerAnimated(false)
        eventsNavLocal = 1
        refresh = 1
    }

    func screenButtonAction(sender:UIButton!) {
        if self.hidden {
            hidden = false
            UIView.animateWithDuration(0.2, animations: {
                self.navigationController?.navigationBar.alpha = 1.0
                UIApplication.sharedApplication().statusBarHidden = false
            })
        }
        else {
            hidden = true
            UIView.animateWithDuration(0.2, animations: {
                UIApplication.sharedApplication().statusBarHidden = true
                self.navigationController?.navigationBar.alpha = 0.0
            })
        }
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
