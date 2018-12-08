//
//  HistoryTableViewCell.swift
//  SendIt
//  This file implements the HistoryViewController class.
//  CPSC 315-01, Fall 2018
//  Project
//
//  Published by Eugene Krug and Kevin Mattappally on 12/12/18.
//  Copyright © 2018 Eugene Krug and Kevin Mattappally. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell
{
    @IBOutlet var mountainLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    
    func update(with run: Run)
    {
        guard let mountain = run.mountain, let runName = run.name, let date = run.startDateTime else {
            return
        }
        let cellDateFormatter = DateFormatter()
        cellDateFormatter.dateFormat = "MM/dd/yyyy"
        mountainLabel.text = "\(mountain): \(runName)"
        dateLabel.text = "Date: \(cellDateFormatter.string(from: date)), Elevation Change: \(run.elevationChange) feet"
    }
}
