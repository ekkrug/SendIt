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
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var elapsedTimeLabel: UILabel!
    
    // reach goal to get an image working
    @IBOutlet var mountainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let validRun = run else {
            return
        }
        mountainRunLabel.text = "\(String(describing: validRun.mountain!)): \(String(describing: validRun.name!))"
        elevationChangeLabel.text = "Elevation Change: \(validRun.elevationChange) feet"
        difficultyLabel.text = "Difficulty: \(String(describing: validRun.difficulty!))"
        // timeToTimeLabel.text = "\(String(describing: validRun.startDateTime!)) - \(String(describing: validRun.endDateTime!))"
        let detailDateFormatter = DateFormatter()
        let detailTimeFormatter = DateFormatter()
        detailTimeFormatter.dateStyle = .none
        detailTimeFormatter.timeStyle = .medium
        detailDateFormatter.dateFormat = "MM/dd/yyyy"
        
        if let startTime = validRun.startDateTime as Date?, let endTime = validRun.endDateTime as Date? {
            dateLabel.text = "Date: \(detailDateFormatter.string(from: startTime))"
            elapsedTimeLabel.text = "Time Duration: \(detailTimeFormatter.string(from: startTime)) - \(detailTimeFormatter.string(from: endTime))"
        }
        
        if let imageFileName = validRun.imageFileName
        {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let fileURL = documentsDirectory.appendingPathComponent(imageFileName).appendingPathExtension("jpeg")
            
            mountainImage.image = UIImage(contentsOfFile: fileURL.path)
        }
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
