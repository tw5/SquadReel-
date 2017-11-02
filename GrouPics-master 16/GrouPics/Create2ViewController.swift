//
//  Create2ViewController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 3/28/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// obtain event end time info

import UIKit

var dateInput : String = String()

class Create2ViewController: UIViewController {

    var date: UIDatePicker!
    let buttonImg = UIImageView()
    var v: UIViewController = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        v = storyboard!.instantiateViewControllerWithIdentifier("createView3") as UIViewController
        // Do any additional setup after loading the view.
        //let v2 = storyboard!.instantiateViewControllerWithIdentifier("createView") as! CreateViewController
        //v2.allowClick = false
        allowClick = true
        // create buttons and titles
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
        //next.setBackgroundImage(circle, forState: UIControlState.Normal)
        next.addTarget(self, action: #selector(Create2ViewController.nextAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        next.addTarget(self, action: #selector(CreateViewController.clickAction(_:)), forControlEvents: UIControlEvents.TouchDown)
        next.addTarget(self, action: #selector(CreateViewController.dragAction(_:)), forControlEvents: UIControlEvents.TouchDragExit)
        buttonImg.frame = CGRectMake(0, 0, next.frame.size.width/1.3, next.frame.size.width/1.6)
        buttonImg.frame.origin.x = (screenSize.width - buttonImg.frame.size.width)/1.95
        buttonImg.frame.origin.y = (next.frame.origin.y + screenSize.height/42)
        //let grayColor = UIColor(red: 137/255, green: 140/255, blue: 145/255, alpha: 1.0)
        buttonImg.image = UIImage(named: "arrow")
        self.view.addSubview(buttonImg)
        
        // allow user to select day and time
        date = UIDatePicker()
        date.frame = CGRectMake(0, 0, screenSize.width * 0.9, screenSize.height * 0.4)
        date.frame.origin.x = (screenSize.width - date.frame.size.width)*0.5
        date.frame.origin.y = (screenSize.height - date.frame.size.height)*0.5
        self.view.addSubview(date)
        self.view.addSubview(next)
        
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    //when user clicks next, obtain date information and proceed if sufficient
    func nextAction(sender:UIButton!) {
        buttonImg.alpha = 1.0
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var d: NSDate = date.date
        
        let date2 = NSDate()
        let calendar = NSCalendar.currentCalendar()
        var components = calendar.components(.Day, fromDate: date2)
        let day = components.day
        components = calendar.components(.Month, fromDate: date2)
        let month = components.month
        components = calendar.components(.Year, fromDate: date2)
        let year = components.year
        components = calendar.components(.Hour, fromDate: date2)
        let hour = components.hour
        components = calendar.components(.Minute, fromDate: date2)
        let min = (components.minute + 1)%60
        let timestamp: String = "\(day)-\(month)-\(year) \(hour):\(min)"
        let currentDate = dateFormatter.dateFromString(timestamp)
        if date.date.compare(currentDate!) == .OrderedAscending {
            let alert = UIAlertView()
            alert.title = "Wait a Sec"
            alert.message = "You cannot create an event that has already concluded"
            alert.addButtonWithTitle("Understood")
            alert.show()
        }
        else {
            dateInput = dateFormatter.stringFromDate(date.date)
            createNavController.pushViewController(v, animated: true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
