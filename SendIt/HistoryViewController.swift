//
//  HistoryViewController.swift
//  SendIt
//  This file implements the HistoryViewController class.
//  CPSC 315-01, Fall 2018
//  Project
//
//  Published by Eugene Krug and Kevin Mattappally on 12/12/18.
//  Copyright © 2018 Eugene Krug and Kevin Mattappally. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var historyTableView: UITableView!
    
    var runs = [Run]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return runs.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunCell", for: indexPath) as! HistoryTableViewCell
        let run = runs[indexPath.row]
        cell.update(with: run)
        return cell
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        historyTableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        let tabBar = tabBarController as! MyTabBarController
        runs = tabBar.runs
        
        historyTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let identifier = segue.identifier else {
            return
        }
        guard identifier == "DetailSegue" else {
            return
        }
        guard let historyDetailVC = segue.destination as? HistoryDetailViewController else {
            return
        }
        guard let indexPath = historyTableView.indexPathForSelectedRow else {
            return
        }
        let run = runs[indexPath.row]
        historyDetailVC.run = run
    }
}
