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
    @IBOutlet var mountainLabel: UILabel!
    @IBOutlet var runNameLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var endLabel: UILabel!
    @IBOutlet var timeElapsedLabel: UILabel!
    @IBOutlet var elevationChangeLabel: UILabel!
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
        let nF = NumberFormatter()
        nF.minimumFractionDigits = 2
        nF.maximumFractionDigits = 2
        var elevationFinal: String = ""
        if isFeet
        {
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
        if let mountain = validRun.mountain
        {
            mountainLabel.text = "Mountain: \(mountain)"
        }
        
        if let run = validRun.name
        {
            runNameLabel.text = "Run: \(run)"
        }
        
        if let difficulty = validRun.difficulty
        {
            difficultyLabel.text = "Difficulty: \(difficulty)"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        if let start = validRun.startDateTime
        {
            startLabel.text = "Start: \(dateFormatter.string(from: start))"
        }
        
        if let end = validRun.endDateTime
        {
            endLabel.text = "End: \(dateFormatter.string(from: end))"
        }
        
        if let timeElapsed = validRun.timeElapsed
        {
            timeElapsedLabel.text = "Time Elapsed: \(timeElapsed)"
        }
        
        if let imageFileName = validRun.imageFileName
        {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let fileURL = documentsDirectory.appendingPathComponent(imageFileName).appendingPathExtension("jpeg")
            
            mountainImage.image = UIImage(contentsOfFile: fileURL.path)
        }
    }
}
