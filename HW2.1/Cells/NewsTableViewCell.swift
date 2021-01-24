//
//  NewsTableViewCell.swift
//  HW2.1
//
//  Created by Илья Павлов on 21.01.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
    static let identifier = "news"


    @IBOutlet weak var senderIconImage: UIImageView!
    @IBOutlet weak var senderIconImageContainer: UIView!
    @IBOutlet weak var senderNameLabel: UILabel!    
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var likeControl: UIView!
    @IBOutlet weak var commentControl: UIView!
    @IBOutlet weak var repostControl: UIView!
    
    
    
    
}
