//
//  GroupCell.swift
//  HW2.1
//
//  Created by Илья Павлов on 23.02.2021.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        groupLabel.text = ""

    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
