//
//  HistoryDetailViewController.swift
//  SendIt
//  This file implements the HistoryDetailViewController class.
//  CPSC 315-01, Fall 2018
//  Project
//
//  Published by Eugene Krug and Kevin Mattappally on 12/12/18.
//  Copyright © 2018 Eugene Krug and Kevin Mattappally. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController
{
    @IBOutlet var mountainRunLabel: UILabel!
    @IBOutlet var elevationChangeLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var elapsedTimeLabel: UILabel!
    @IBOutlet var mountainImage: UIImageView!
    
    var run: Run? = nil
    
    
    override func viewDidLoad()
    {
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
    }
}
