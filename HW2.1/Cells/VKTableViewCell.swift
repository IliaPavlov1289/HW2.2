//
//  GroupTableViewCell.swift
//  HW2.1
//
//  Created by Илья Павлов on 07.01.2021.
//

import UIKit

class VKTableViewCell: UITableViewCell {

    @IBOutlet weak var cellVKImage: UIImageView!
    @IBOutlet weak var cellVKLabel: UILabel!
    @IBOutlet weak var cellVKImageContainer: UIView!
    
    var cellId = 0.0
    
//    override func prepareForReuse() {
//        groupLabel.text = ""
//
//    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        cellVKImage.layer.cornerRadius = cellVKImage.frame.width / 2
        cellVKImageContainer.layer.cornerRadius = cellVKImageContainer.frame.width / 2
        cellVKImageContainer.layer.shadowColor = UIColor.blue.cgColor
        cellVKImageContainer.layer.shadowOffset = CGSize(width: 5, height: 1)
        cellVKImageContainer.layer.shadowRadius = 4
        cellVKImageContainer.layer.shadowOpacity = 0.4
    }
    
    func downLoadImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                let uiImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.cellVKImage.image = uiImage
                }
                
            }
        }.resume()
    }
    
}
