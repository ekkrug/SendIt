//
//  HistoryTableViewCell.swift
//  SendIt
//
//  Created by Kevin Mattappally on 11/30/18.
//  Copyright © 2018 SendIt. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet var mountainLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with run: Run) {
        guard let mountain = run.mountain, let runName = run.name, let date = run.startDateTime else {
            return
        }
        let cellDateFormatter = DateFormatter()
        cellDateFormatter.dateFormat = "MM/dd/yyyy"
        mountainLabel.text = "\(mountain): \(runName)"
        dateLabel.text = "Date: \(cellDateFormatter.string(from: date)), Elevation Change: \(run.elevationChange) feet"
    }

}
