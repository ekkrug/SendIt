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

class RunViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate
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
    
    var finishDateTime: Date? = nil
    
    
    
    
    @IBOutlet weak var mountainTF: UITextField!
    
    @IBOutlet weak var runNameTF: UITextField!
    
    @IBOutlet weak var difficultyTF: UITextField!
    
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var finishLabel: UILabel!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func recordFinishButtonPressed(_ sender: UIButton)
    {
        finishDateTime = Date(timeIntervalSinceNow: 0)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        
        if let finishDateTime = finishDateTime
        {
            finishLabel.text = "Finish: \(dateFormatter.string(from: finishDateTime))"
        }
    }
    
    
    @IBAction func addAPhotoButtonPressed(_ sender: UIButton)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Check if camera is a source type available
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        // Check if the photo library is a source type available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     Tells the delegate that the user picked a still image or movie.
     Parameters:
     - picker: a UIImagePickerController
     - info: a dictionary of UIIMagePickerController.InfoKey and Any types
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView?.image = selectedImage
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    /**
     writeImage()​ is called when the user presses save and their new trip has an image.
     Saves the user’s trip image as a JPEG file.
     - Parameter image: a UIImage
     - Returns: a String containing the filename
     */
    func writeImage(image: UIImage) -> String
    {
        let filename = "\(UUID().uuidString)"
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(filename).appendingPathExtension("jpeg")
        let dataInstanceOfImag = image.jpegData(compressionQuality: 0.5)
        
        
        do
        {
            try dataInstanceOfImag?.write(to: fileURL)
        }
        catch
        {
            print("Error writing the data instance")
        }
        return filename
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
        
        if sender as AnyObject? === saveButton
        {
            let newRun = Run(context: self.context)
            
            newRun.mountain = mountainTF.text
            newRun.name = runNameTF.text
            newRun.difficulty = difficultyTF.text
            newRun.startDateTime = startDateTime
            
            if let endDateTime = finishDateTime
            {
                newRun.endDateTime = endDateTime
            }
            else
            {
                newRun.endDateTime = Date(timeIntervalSinceNow: 0)
            }
            
            
            
            
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
            
            if let image = imageView?.image
            {
                newRun.imageFileName = writeImage(image: image)
            }
            else
            {
                newRun.imageFileName = nil
            }

            
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
