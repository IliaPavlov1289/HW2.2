//
//  FrendFotoCollectionViewCell.swift
//  HW2.1
//
//  Created by Илья Павлов on 08.01.2021.
//

import UIKit

class FriendFotoCollectionViewCell: UICollectionViewCell {
   

    @IBOutlet weak var friendFotoImage: UIImageView!
//    var friendPhotoBigImage = UIImageView()
    
    func downLoadImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                let uiImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.friendFotoImage.image = uiImage
                }
            }
        }.resume()
//        URLSession.shared.dataTask(with: bigImageUrl) { [weak self] (data, response, error) in
//            if let data = data {
//                let uiImage = UIImage(data: data)
//                DispatchQueue.main.async {
//                    self?.friendPhotoBigImage.image = uiImage
//                }
//            }
//        }.resume()
    }
    
}
    



