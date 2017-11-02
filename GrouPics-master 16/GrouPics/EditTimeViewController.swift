//
//  SetTimeViewController.swift
//  GrouPics
//
//  Created by Thomas Weng on 4/28/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// allow host to change endtime of event

import UIKit
class EditTimeViewController: UIViewController {
    var date: UIDatePicker!
    var newDate : String = String()
    let eventRef = dataBase.childByAppendingPath("events/" + eventName)
    
    //create titles, buttons, and date selector
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let dullRedColor = UIColor(red: 193/255.0, green: 113/255.0, blue: 104/255.0, alpha: 1.0)

        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.whiteColor() //veryDullRedColor
        titleLabel.text = "Change event end time?"
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont(name: "Menlo-Bold", size: 25*screenSize.width/375)
        titleLabel.frame = CGRectMake(0, 0, screenSize.width, screenSize.height * 0.15)
        titleLabel.frame.origin.x = (screenSize.width - titleLabel.frame.size.width)/2
        titleLabel.frame.origin.y = (screenSize.height - titleLabel.frame.size.height)*0.1
        titleLabel.alpha = 1.0
        self.view.addSubview(titleLabel)
        
        date = UIDatePicker()
        date.frame = CGRectMake(0, 0, screenSize.width * 0.9, screenSize.height * 0.4)
        date.frame.origin.x = (screenSize.width - date.frame.size.width)*0.5
        date.frame.origin.y = (screenSize.height - date.frame.size.height)*0.4
        date.tintColor = UIColor.whiteColor()
        date.setValue(UIColor.whiteColor(), forKey:"textColor")
        self.view.addSubview(date)
        
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
        
        
    }
    
    //save new end time
    func saveAction(sender:UIButton!) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var d: NSDate = date.date
        newDate = dateFormatter.stringFromDate(date.date)
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
            var tempRef = eventRef.childByAppendingPath("end time/")
            tempRef.setValue(newDate)
        }
        eventsNavController.popViewControllerAnimated(true)
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