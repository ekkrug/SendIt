//
//  SettingsViewController.swift
//  SendIt
//
//  Created by Eugene Krug on 12/8/18.
//  Copyright © 2018 SendIt. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var isFeet = true
    {
        didSet
        {
            let tabBar = tabBarController as! MyTabBarController
            tabBar.isFeet = isFeet
        }
    }
    
    @IBAction func feetMetersValueChanged(_ sender: UISegmentedControl)
    {
        let index = sender.selectedSegmentIndex
        
        if index == 0 // feet
        {
            isFeet = true
            print("feet")
        }
        else // meters
        {
            isFeet = false
            print("meters")
        }
    }
    
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
