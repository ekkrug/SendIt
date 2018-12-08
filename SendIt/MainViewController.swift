//
//  MainViewController.swift
//  SendIt
//  This file implements the MainViewController class.
//  CPSC 315-01, Fall 2018
//  Project
//
//  Published by Eugene Krug and Kevin Mattappally on 12/12/18.
//  Copyright © 2018 Eugene Krug and Kevin Mattappally. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var mountainLabel: UILabel!
    @IBOutlet weak var runNameLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var elevationChangeLabel: UILabel!
    @IBOutlet weak var nextRunMountainLabel: UILabel!
    @IBOutlet weak var nextRunMountainTF: UITextField!
    @IBOutlet weak var nextRunDifficultyLabel: UILabel!
    @IBOutlet weak var nextRunDifficultyTF: UITextField!
    @IBOutlet weak var nextRunNameLabel: UILabel!
    @IBOutlet weak var nextRunNameTF: UITextField!
    
    @IBAction func unwindToMainViewController(unwindSegue: UIStoryboardSegue)
    {
        if let identifer = unwindSegue.identifier
        {
            if identifer == "finishButtonPressedUnwind"
            {
                addNewRun()
            }
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var runs = [Run]()
    
    var nextRunDifficultyPicker = UIPickerView()
    let nextRunDifficultyPickerData = ["Easiest", "Intermediate", "Advanced", "Expert Only"]
    
    var isFeet = true
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == nextRunDifficultyPicker
        {
            return nextRunDifficultyPickerData.count
        }
        else
        {
            return 0
        }
    }
    
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == nextRunDifficultyPicker
        {
            return nextRunDifficultyPickerData[row]
        }
        else
        {
            return nil
        }
    }
    
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == nextRunDifficultyPicker
        {
            return nextRunDifficultyTF.text = nextRunDifficultyPickerData[row]
        }
        
    }
    
    
    func loadRuns()
    {
        let request: NSFetchRequest<Run> = Run.fetchRequest()
        
        do
        {
            runs = try context.fetch(request)
        }
        catch
        {
            print("Error fetching runs: \(error)")
        }
    }
    
    
    func saveRuns()
    {
        do
        {
            try context.save()
        }
        catch
        {
            print("Error saving runs: \(error)")
        }
        let tabBar = tabBarController as! MyTabBarController
        tabBar.runs = runs
    }
    
    
    func addNewRun()
    {
        self.saveRuns()
    }
    
    
    func updateLabelsFieldsMain()
    {
        if runs.count == 0
        {
            mountainLabel.text = "No runs stored!"
            runNameLabel.text = "SendIt on your first run!"
            difficultyLabel.text = " "
            startLabel.text = " "
            endLabel.text = " "
            timeElapsedLabel.text = " "
            elevationChangeLabel.text = " "
        }
        else
        {
            if let lastRun = runs.last
            {
                if let mountain = lastRun.mountain
                {
                    mountainLabel.text = "Mountain: \(mountain)"
                    nextRunMountainTF.text = mountain
                }
                
                if let run = lastRun.name
                {
                    runNameLabel.text = "Run: \(run)"
                    nextRunNameTF.text = run
                }
                
                if let difficulty = lastRun.difficulty
                {
                    difficultyLabel.text = "Difficulty: \(difficulty)"
                   nextRunDifficultyTF.text = difficulty
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                dateFormatter.locale = Locale(identifier: "en_US")
                
                if let start = lastRun.startDateTime
                {
                    startLabel.text = "Start: \(dateFormatter.string(from: start))"
                }
                
                if let end = lastRun.endDateTime
                {
                    endLabel.text = "End: \(dateFormatter.string(from: end))"
                }
                
                if let timeElapsed = lastRun.timeElapsed
                {
                    timeElapsedLabel.text = "Time Elapsed: \(timeElapsed)"
                }
               
                let nF = NumberFormatter()
                nF.minimumFractionDigits = 2
                nF.maximumFractionDigits = 2
                
                
                if isFeet // feet
                {
                    let eCFeetNSNum = NSNumber(value: lastRun.elevationChange)
                    if let eCFeetDisp = nF.string(from: eCFeetNSNum)
                    {
                        elevationChangeLabel.text = "Elevation Change: \(eCFeetDisp) feet"
                    }
                    else
                    {
                        elevationChangeLabel.text = "Elevation Change: unknown"
                    }
                }
                else // meters
                {
                    let eCMetersDbl = Conversion.feetToMeters(inFeet: lastRun.elevationChange)
                    let eCMetersNSNum = NSNumber(value: eCMetersDbl)
                    if let ecMetersDisp = nF.string(from: eCMetersNSNum)
                    {
                        elevationChangeLabel.text = "Elevation Change: \(ecMetersDisp) meters"
                    }
                    else
                    {
                        elevationChangeLabel.text = "Elevation Change: unknown"
                    }
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueToRunVC"
        {
            let destVC = segue.destination as! RunViewController
            
        
            if let nextRunMountain = nextRunMountainTF.text
            {
                destVC.mountainInit = nextRunMountain
            }
            
            if let nextRunName = nextRunNameTF.text
            {
                destVC.runNameInit = nextRunName
            }
            
            if let nextRunDifficulty = nextRunDifficultyTF.text
            {
                destVC.difficultyInit = nextRunDifficulty
            }
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("\(documentsDirectory)")
        
        loadRuns()
        updateLabelsFieldsMain()
        
        nextRunDifficultyPicker = UIPickerView()
        nextRunDifficultyTF.inputView = nextRunDifficultyPicker
        nextRunDifficultyPicker.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        let tabBar = tabBarController as! MyTabBarController
        tabBar.runs = runs
        isFeet = tabBar.isFeet
        updateLabelsFieldsMain()
    }
}

