//
//  HistoryViewController.swift
//  SendIt
//
//  Created by Eugene Krug on 11/20/18.
//  Copyright © 2018 SendIt. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var runs = [Run]()
    @IBOutlet var historyTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return runs.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunCell", for: indexPath) as! HistoryTableViewCell
        let run = runs[indexPath.row]
        cell.update(with: run)
        // cell.showsReorderControl = true
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        historyTableView.reloadData()
    }
}
