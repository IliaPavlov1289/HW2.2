//
//  GroupTableViewCell.swift
//  HW2.1
//
//  Created by Илья Павлов on 07.01.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var groupImageContainer: UIView!
    
    override func prepareForReuse() {
        groupLabel.text = ""

    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        groupImage.layer.cornerRadius = groupImage.frame.width / 2
        groupImageContainer.layer.cornerRadius = groupImageContainer.frame.width / 2
        groupImageContainer.layer.shadowColor = UIColor.blue.cgColor
        groupImageContainer.layer.shadowOffset = CGSize(width: 5, height: 1)
        groupImageContainer.layer.shadowRadius = 4
        groupImageContainer.layer.shadowOpacity = 0.4
    }
    
}
