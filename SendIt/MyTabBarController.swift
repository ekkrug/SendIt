//
//  MyTabBarController.swift
//  SendIt
//
//  Created by Kevin Mattappally on 12/3/18.
//  Copyright © 2018 SendIt. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    var runs: [Run] = []
    
    var isFeet = true
    {
        didSet
        {
            print("did set to: \(isFeet)")
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
