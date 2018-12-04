//
//  ViewController.swift
//  SendIt
//
//  Created by Eugene Krug on 11/20/18.
//  Copyright © 2018 SendIt. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var nextRunMountainPicker = UIPickerView()
    var nextRunDifficultyPicker = UIPickerView()
    
    var nextRunMountainPickerData = [String]()
    let nextRunDifficultyPickerData = ["Easiest", "Intermediate", "Advanced", "Expert Only"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == nextRunMountainPicker
        {
            return nextRunMountainPickerData.count
        }
        else if pickerView == nextRunDifficultyPicker
        {
            return nextRunDifficultyPickerData.count
        }
        else
        {
            return 0
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == nextRunMountainPicker
        {
            return nextRunMountainPickerData[row]
        }
        else if pickerView == nextRunDifficultyPicker
        {
            return nextRunDifficultyPickerData[row]
        }
        else
        {
            return nil
        }
        
        
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //pickerView.isHidden = true
        //print("SELECTED")
        
        
        
        if pickerView == nextRunMountainPicker
        {
            return nextRunMountainTF.text = nextRunMountainPickerData[row]
        }
        else if pickerView == nextRunDifficultyPicker
        {
            return nextRunDifficultyTF.text = nextRunDifficultyPickerData[row]
        }
        
    }
    
    
    
    /*
     func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
     {
     textfieldBizCat.text = bizCat[row]
     pickerBizCat.hidden = true;
     }
     
     func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
     pickerBizCat.hidden = false
     return false
     }
    */
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var runs = [Run]()
    
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
                print("finishButtonPressedUnwind")
                addNewRun()
                //TODO
                print("runs count: \(runs.count)")
            }
            
        }
        
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
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
               
                
                
                elevationChangeLabel.text = "Elevation Change: \(lastRun.elevationChange) feet"
        }
    }
    
   
    
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRunVC"
        {
            /*
             let destVC = segue.destination as! MainViewController
             
             if sender as AnyObject? === finishButton
             {
            */
            
            let destVC = segue.destination as! RunViewController
            
            destVC.curRunMountainPickerData = nextRunMountainPickerData
            
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("********VIEW DID LOAD**********")
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("\(documentsDirectory)")
        
        loadRuns()
        updateLabelsFieldsMain()
        
        for cur in runs
        {
            if let curMountain = cur.mountain
            {
                if !nextRunMountainPickerData.contains(curMountain)
                {
                    nextRunMountainPickerData.append(curMountain)
                }
            }
        }
        nextRunMountainPickerData.sort()
        
        //TODO
        nextRunMountainPicker = UIPickerView()
        //nextRunMountainTF.inputView = nextRunMountainPicker
        nextRunMountainPicker.delegate = self
        
        
        nextRunDifficultyPicker = UIPickerView()
        nextRunDifficultyTF.inputView = nextRunDifficultyPicker
        nextRunDifficultyPicker.delegate = self
        //theTextfield.inputView = thePicker
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        updateLabelsFieldsMain()
        let tabBar = tabBarController as! MyTabBarController
        tabBar.runs = runs
    }


}

