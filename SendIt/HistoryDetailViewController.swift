//
//  HistoryDetailViewController.swift
//  SendIt
//
//  Created by Kevin Mattappally on 12/3/18.
//  Copyright © 2018 SendIt. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {

    var run: Run? = nil
    
    @IBOutlet var mountainRunLabel: UILabel!
    @IBOutlet var elevationChangeLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    @IBOutlet var timeToTimeLabel: UILabel!
    @IBOutlet var elapsedTimeLabel: UILabel!
    
    // reach goal to get an image working
    @IBOutlet var mountainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayRuns() {
        guard let validRun = run else {
            return
        }
        mountainRunLabel.text = "\(String(describing: validRun.mountain)): \(String(describing: validRun.name))"
        elevationChangeLabel.text = "\(validRun.elevationChange)"
        elevationChangeLabel.text = "\(validRun.elevationChange)"
        difficultyLabel.text = "\(String(describing: validRun.difficulty))"
        timeToTimeLabel.text = "\(String(describing: validRun.startDateTime)) - \(String(describing: validRun.endDateTime))"
        let detailDateFormatter = DateFormatter()
        detailDateFormatter.dateFormat = "MM/dd/yyyy"
        if let startTime = validRun.startDateTime as Date?, let endTime = validRun.endDateTime as Date? {
            timeToTimeLabel.text = "\(startTime) - \(endTime)"
        }
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
