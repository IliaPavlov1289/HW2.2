//
//  MyGroupTableViewCell.swift
//  HW2.1
//
//  Created by Илья Павлов on 08.01.2021.
//

import UIKit

class MyGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var myGroupImage: UIImageView!
    @IBOutlet weak var myGroupLabel: UILabel!
    @IBOutlet weak var myGroupImageContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myGroupImage.layer.cornerRadius = myGroupImage.frame.width / 2
        myGroupImageContainer.layer.cornerRadius = myGroupImageContainer.frame.width / 2
        myGroupImageContainer.layer.shadowColor = UIColor.blue.cgColor
        myGroupImageContainer.layer.shadowOffset = CGSize(width: 5, height: 1)
        myGroupImageContainer.layer.shadowRadius = 4
        myGroupImageContainer.layer.shadowOpacity = 0.4
    }
    
}
