//
//  RunViewController.swift
//  SendIt
//
//  Created by Eugene Krug on 11/20/18.
//  Copyright © 2018 SendIt. All rights reserved.
//

import UIKit
import CoreData
import CoreMotion

class RunViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource 
{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var altitudeManager = CMAltimeter()
    var curRelAltMeters = NSNumber()
    
    var curRunMountainPicker = UIPickerView()
    var curRunDifficultyPicker = UIPickerView()
    
    var curRunMountainPickerData = [String]()
    let curRunDifficultyPickerData = ["Easiest", "Intermediate", "Advanced", "Expert Only"]
    
    var startDateTime = Date()
    var mountainInit = String()
    var runNameInit = String()
    var difficultyInit = String()
    
    
    
    
    @IBOutlet weak var mountainTF: UITextField!
    
    @IBOutlet weak var runNameTF: UITextField!
    
    @IBOutlet weak var difficultyTF: UITextField!
    
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == curRunMountainPicker
        {
            return curRunMountainPickerData.count
        }
        else if pickerView == curRunDifficultyPicker
        {
            return curRunDifficultyPickerData.count
        }
        else
        {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == curRunMountainPicker
        {
            return curRunMountainPickerData[row]
        }
        else if pickerView == curRunDifficultyPicker
        {
            return curRunDifficultyPickerData[row]
        }
        else
        {
            return nil
        }
    }
    
  
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == curRunMountainPicker
        {
            return mountainTF.text = curRunMountainPickerData[row]
        }
        else if pickerView == curRunDifficultyPicker
        {
            return difficultyTF.text = curRunDifficultyPickerData[row]
        }
      
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destVC = segue.destination as! MainViewController
        
        if sender as AnyObject? === finishButton
        {
            let newRun = Run(context: self.context)
            
            newRun.mountain = mountainTF.text
            newRun.name = runNameTF.text
            newRun.difficulty = difficultyTF.text
            newRun.startDateTime = startDateTime
            newRun.endDateTime = Date(timeIntervalSinceNow: 0)
            altitudeManager.stopRelativeAltitudeUpdates()
            
            //let curRelAltMetersDbl = curRelAltMeters.doubleValue
            //let curRelAltFeetDbl = curRelAltMetersDbl * 3.281
            
            let nF = NumberFormatter()
            nF.minimumFractionDigits = 2
            nF.maximumFractionDigits = 2
            
            let curRelAltFeetDbl = Double(truncating: curRelAltMeters) * 3.281
            let curRelAltFeetNSNum = NSNumber(value: curRelAltFeetDbl)
            
            if let elevationChangeStr = nF.string(from: curRelAltFeetNSNum)
            {
                if let elevationChangeDbl = Double(elevationChangeStr)
                {
                    newRun.elevationChange = elevationChangeDbl
                }
            }
            
            //let bal = Double(nF.string(from: curRelAltMeters))
            
            
          
            
            //newRun.elevationChange = 10.0

            
            let tI = newRun.endDateTime!.timeIntervalSince(newRun.startDateTime!) // TODO
            let dCF = DateComponentsFormatter()
            dCF.unitsStyle = .abbreviated
            newRun.timeElapsed = dCF.string(from: tI)
            
            

            
            destVC.self.runs.append(newRun)
            
            if let mountain = mountainTF.text
            {
                if !destVC.nextRunMountainPickerData.contains(mountain)
                {
                    destVC.nextRunMountainPickerData.append(mountain)
                    destVC.nextRunMountainPickerData.sort()
                }
            }
            
           
        }
        
    }
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?)
     {
     let destVC = segue.destination as! TripTableViewController
     
     
     if sender as AnyObject? === saveButton
     {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "MM/dd/yyyy"
     
     // It is okay to force unwrap here because this function to prepare for segue
     // is only called if all the user's input has been validated. The logic to
     // validate the user's input occurs in the function shouldPerformSegue, which
     // returns true or false if it is okay to perform the segue (this function).
     //let newTrip = Trip(destinationName: destinationTF.text!, startDate: dateFormatter.date(from: startDateTF.text!)!, endDate: dateFormatter.date(from: endDateTF.text!)!, imageFileName: nil)
     // TODO
     let newTrip = Trip(context: self.context)
     newTrip.destinationName = destinationTF.text!
     newTrip.startDate = dateFormatter.date(from: startDateTF.text!)!
     newTrip.endDate = dateFormatter.date(from: endDateTF.text!)!
     
     
     if let image = imageView?.image
     {
     newTrip.imageFileName = writeImage(image: image)
     }
     else
     {
     newTrip.imageFileName = nil
     }
     
     
     
     destVC.self.trips.append(newTrip)
     
     //destVC.trips.append(newTrip)
     }
     }
    */
    
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        startDateTime = Date(timeIntervalSinceNow: 0)
        
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altitudeManager.startRelativeAltitudeUpdates(to: OperationQueue.main) { (data, error) in
                if let curAltitude = data?.relativeAltitude
                {
                    self.curRelAltMeters = curAltitude
                }
                // TODO handle
            }

        } else {
            print("Your iphone doesn't have a barometer :(.")
            // TODO: better way to handle?
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        
        startLabel.text = "Start: \(dateFormatter.string(from: startDateTime))"
        mountainTF.text = mountainInit
        runNameTF.text = runNameInit
        difficultyTF.text = difficultyInit
        
        curRunMountainPicker = UIPickerView()
        //mountainTF.inputView = curRunMountainPicker
        curRunMountainPicker.delegate = self
        
        curRunDifficultyPicker = UIPickerView()
        difficultyTF.inputView = curRunDifficultyPicker
        curRunDifficultyPicker.delegate = self
    }
}
