//
//  FrendTableViewCell.swift
//  HW2.1
//
//  Created by Илья Павлов on 08.01.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendFotoIconImage: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendFotoIconContainer: UIView!
    
    @IBInspectable var shadowRadius: CGFloat = 4 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shadowOpacity: Float = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shadowColor: UIColor = .blue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendFotoIconImage.layer.cornerRadius = friendFotoIconImage.frame.width / 2
        friendFotoIconContainer.layer.cornerRadius = friendFotoIconContainer.frame.width / 2
        friendFotoIconContainer.layer.shadowColor = shadowColor.cgColor
        friendFotoIconContainer.layer.shadowOffset = CGSize(width: 5, height: 1)
        friendFotoIconContainer.layer.shadowRadius = shadowRadius
        friendFotoIconContainer.layer.shadowOpacity = shadowOpacity
    }
    
    
    
}
