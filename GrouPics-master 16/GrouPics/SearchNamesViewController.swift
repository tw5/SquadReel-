//
//  SearchUIViewController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 4/28/16.
//  Copyright © 2016 Tom. All rights reserved.
//
import Firebase
import UIKit
//public typealias JSON = [String : AnyObject]

// search events by name 
class SearchNamesViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var name: UITextView!
    
    var buttonCount : Int!
    
    var yPos: CGFloat = -50 //20
    
    let darkGreenColor = UIColor(red: 19/255.0, green: 35/255.0, blue: 19/255.0, alpha: 1.0)
    let lightGreenColor = UIColor(red: 199/255.0, green: 215/255.0, blue: 198/255.0, alpha: 1.0)
    let lightOrangeColor = UIColor(red: 232/255.0, green: 180/255.0, blue: 80/255.0, alpha: 1.0)
    let lightWhiteColor = UIColor(red: 249/255.0, green: 253/255.0, blue: 248/255.0, alpha: 1.0)
    let darkOrangeColor = UIColor(red: 159/255.0, green: 108/255.0, blue: 8/255.0, alpha: 1.0)
    let darkRedColor = UIColor(red: 109/255.0, green: 32/255.0, blue: 24/255.0, alpha: 1.0)
    let leafGreenColor = UIColor(red: 108/255.0, green: 177/255.0, blue: 115/255.0, alpha: 1.0)
    let dullOrangeColor = UIColor(red: 177/255.0, green: 145/255.0, blue: 108/255.0, alpha: 1.0)
    let blueColor = UIColor(red: 136/255, green: 175/255, blue: 239/255, alpha: 1.0)
    let darkBlueColor = UIColor(red: 0/255, green: 48/255, blue: 92/255, alpha: 1.0)
    let lightBlueColor = UIColor(red: 50/255, green: 70/255, blue: 147/255, alpha: 1.0)
    let borderColor = UIColor(red: 204.0/255.0, green:204.0/255.0, blue:204.0/255.0, alpha:1.0)
    let normGreenColor = UIColor(red: 78/255.0, green: 155/255.0, blue: 86/255.0, alpha: 1.0)

    var hosts = [String]()
    var joins = [String]()
    
    var searchEventsView: SearchEventsViewController = SearchEventsViewController()
    var detailsView: EventDetailsViewController = EventDetailsViewController()

    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()

    // create buttons and titles and search bar
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        searchEventsView = storyboard!.instantiateViewControllerWithIdentifier("searchEventsView") as! SearchEventsViewController
        detailsView = storyboard!.instantiateViewControllerWithIdentifier("eventDetailsView") as! EventDetailsViewController
        
        self.scrollView = UIScrollView()
        self.scrollView.backgroundColor = UIColor.lightGrayColor()
        self.scrollView.autoresizingMask = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        self.scrollView.frame = CGRectMake(0, 0, screenSize.width*0.88 + (2 + 0.5 * (4-1)) * 5, screenSize.height*0.65)
        self.scrollView.frame.origin.x = (screenSize.width - self.scrollView.frame.width)*0.5
        self.scrollView.frame.origin.y = screenSize.height*0.23
        let diff = screenSize.height/10
        self.scrollView.frame.size.height -= diff
        self.scrollView.frame.origin.y += diff
        self.scrollView.contentSize.height = self.yPos
        self.view.addSubview(self.scrollView)
        
        activityIndicator.frame.origin.x = scrollView.frame.size.width/2
        activityIndicator.frame.origin.y = scrollView.frame.size.height/3.2
        activityIndicator.transform = CGAffineTransformMakeScale(6, 6)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        self.scrollView.addSubview(activityIndicator)
        
        let searchBar = UIButton()
        searchBar.titleLabel!.font = UIFont(name: "Menlo", size: 21*screenSize.width/320) //Chalkboard SE
        searchBar.setTitle("search", forState: UIControlState.Normal)
        searchBar.setTitleColor(self.darkGreenColor, forState: UIControlState.Normal)
        searchBar.backgroundColor = UIColor.whiteColor()
        searchBar.frame = CGRectMake(0, 0, self.scrollView.frame.width*0.9, self.scrollView.frame.height*0.15)
        searchBar.frame.origin.x = (screenSize.width - searchBar.frame.width)*0.5
        searchBar.frame.origin.y =  self.scrollView.frame.origin.y - screenSize.height/9
        searchBar.layer.cornerRadius = 10
        searchBar.addTarget(self, action: "search:", forControlEvents: UIControlEvents.TouchUpInside)
        searchBar.addTarget(self, action: "searchHeld:", forControlEvents: UIControlEvents.TouchDown)
        
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = self.leafGreenColor.CGColor
        self.view.addSubview(searchBar)
        
        name = UITextView()
        name.frame = CGRectMake(0, 0, screenSize.width * 0.7, screenSize.height * 0.06)
        name.frame.origin.x = (screenSize.width - name.frame.size.width)/2
        name.frame.origin.y = (searchBar.frame.origin.y - screenSize.height/12)
        name.layer.borderColor = borderColor.CGColor
        name.layer.borderWidth = 0.8
        name.layer.cornerRadius = 5.0
        name.autocorrectionType = .No
        name.contentSize.height = name.frame.size.height
        self.view.addSubview(name)

        
    }
    
    func searchHeld(sender:Button!) {
        sender.alpha = 0.6
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    func nextAction(sender:Button!) {
        searchEventsNavController.pushViewController(detailsView, animated: true)
        eventName = sender.string
    }
    
    // when user clicks search
    func search(sender:Button!) {
        dismissKeyboard()
        sender.alpha = 1.0
        if name.text.characters.count > 0 {
        //activityIndicator.startAnimating()
        let subViews = self.scrollView.subviews
        for subview in subViews{
            subview.removeFromSuperview()
        }
        yPos = -50//20
        buttonCount = 0
        let eventRef = Firebase(url: "https://groupics333.firebaseio.com/locations/")
        self.activityIndicator.startAnimating()
        // query for events starting with the letters inputted
        eventRef.queryOrderedByKey().queryStartingAtValue(name.text.lowercaseString).queryEndingAtValue("\(name.text.lowercaseString)\u{f8ff}").observeEventType(.ChildAdded, withBlock: { snapshot in
            let key = snapshot.key
            let title = key.componentsSeparatedByString("^")[0]
            let notHost: Bool = (!hostStrings.contains(key)) && (lastHostedEvent != key)
            let notJoin: Bool = !joinStrings.contains(key)
            if notHost && notJoin{
                let button = Button()
                button.titleLabel!.font = UIFont(name: "Menlo", size: 21*screenSize.width/320)
                button.setTitle(title, forState: UIControlState.Normal)
                button.setTitleColor(self.lightWhiteColor, forState: UIControlState.Normal)
                button.string = key
                if (self.buttonCount % 2 == 0) {
                    //button.backgroundColor = self.darkGreenColor//UIColor.whiteColor()
                    button.backgroundColor = self.lightWhiteColor//dullOrangeColor
                    button.setTitleColor(self.normGreenColor, forState: UIControlState.Normal)
                }
                else if (self.buttonCount % 2 == 1) {
                    button.backgroundColor = self.leafGreenColor//UIColor.whiteColor()
                }
                button.frame = CGRectMake(0, 0, self.scrollView.frame.width*0.9, screenSize.height*0.09)
                button.frame.origin.x = (self.scrollView.frame.width - button.frame.width)*0.5
                button.frame.origin.y = self.yPos
                button.layer.cornerRadius = 10
                
                button.addTarget(self, action: #selector(SearchEventsViewController.nextAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                self.scrollView.addSubview(button)
                
                let yPosDiff = screenSize.height/60
                self.yPos = self.yPos + button.frame.size.height + yPosDiff
                
                self.buttonCount = self.buttonCount + 1
                
                self.scrollView.contentSize.height = 20 + 20 + CGFloat(self.buttonCount)*(button.frame.size.height + yPosDiff)
            }
            self.activityIndicator.stopAnimating()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}


