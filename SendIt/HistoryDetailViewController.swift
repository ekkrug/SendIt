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
    var isFeet: Bool = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let tabBar = tabBarController as! MyTabBarController
        isFeet = tabBar.isFeet
        updateView()
    }
    
    func updateView() {
        guard let validRun = run else {
            return
        }
        mountainRunLabel.text = "\(String(describing: validRun.mountain!)): \(String(describing: validRun.name!))"
        let nF = NumberFormatter()
        nF.minimumFractionDigits = 2
        nF.maximumFractionDigits = 2
        var elevationFinal: String = ""
        if isFeet {
            let eCFeetNSNum = NSNumber(value: validRun.elevationChange)
            if let eCFeetDisp = nF.string(from: eCFeetNSNum) {
                elevationFinal = "\(eCFeetDisp) feet"
            } else {
                elevationFinal = "unknown"
            }
        } else {
            let eCMetersDbl = Conversion.feetToMeters(inFeet: validRun.elevationChange)
            let eCMetersNSNum = NSNumber(value: eCMetersDbl)
            if let ecMetersDisp = nF.string(from: eCMetersNSNum)
            {
                elevationFinal = "\(ecMetersDisp) meters"
            }
            else
            {
                elevationFinal = "unknown"
            }
        }
        elevationChangeLabel.text = "Elevation Change: \(elevationFinal)"
        difficultyLabel.text = "Difficulty: \(String(describing: validRun.difficulty!))"
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
