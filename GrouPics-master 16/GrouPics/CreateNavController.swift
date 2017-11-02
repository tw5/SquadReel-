//
//  CreateNavController.swift
//  GrouPics
//
//  Created by Tom and Andrew on 3/28/16.
//  Copyright © 2016 Tom. All rights reserved.
//

import UIKit

//Navigation for all create pages
var createNavController: UINavigationController = UINavigationController()

class CreateNavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavController = self as UINavigationController
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
    //tom is dumb

}