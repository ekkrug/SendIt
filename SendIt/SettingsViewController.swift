//
//  SettingsViewController.swift
//  SendIt
//  This file implements the SettingsViewController class.
//  CPSC 315-01, Fall 2018
//  Project
//
//  Published by Eugene Krug and Kevin Mattappally on 12/12/18.
//  Copyright © 2018 Eugene Krug and Kevin Mattappally. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController
{
    @IBAction func feetMetersValueChanged(_ sender: UISegmentedControl)
    {
        let index = sender.selectedSegmentIndex
        
        if index == 0 // feet
        {
            isFeet = true
        }
        else // meters
        {
            isFeet = false
        }
    }
    
    
    var isFeet = true
    {
        didSet
        {
            let tabBar = tabBarController as! MyTabBarController
            tabBar.isFeet = isFeet
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
