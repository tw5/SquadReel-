//
//  SearchEventsNavigationController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 4/12/16.
//  Copyright © 2016 Tom. All rights reserved.
//

// navigation controller for joining/searching for events
import UIKit


var searchEventsNavController: UINavigationController = UINavigationController()
class SearchEventsNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchEventsNavController = self as UINavigationController
        let greenBackColor = UIColor(red: 45/255, green: 184/255, blue: 58/255, alpha: 1.0)
        self.navigationBar.tintColor = greenBackColor
        // Do any additional setup after loading the view.
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
