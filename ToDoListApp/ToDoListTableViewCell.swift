//
//  ToDoListTableViewCell.swift
//  ToDoListApp
//
//  Created by Ricardo Bravo Acuña on 10/26/19.
//  Copyright © 2019 Ricardo Bravo Acuña. All rights reserved.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTextLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
