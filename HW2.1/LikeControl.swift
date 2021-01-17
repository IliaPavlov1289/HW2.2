//
//  LikeControl.swift
//  HW2.1
//
//  Created by Илья Павлов on 14.01.2021.
//

import UIKit

class LikeControl: UIControl {
      
    var countLike: Int = 0
    var isLiked: Bool = false
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        likeButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        likeButton()
    }
    
    private func likeButton(){
        let likeButton = UIButton(type: .custom)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setTitle("\(countLike)", for: .normal)
        likeButton.setTitleColor(.black, for: .normal)
        likeButton.tintColor = .red
        likeButton.contentHorizontalAlignment = .left
        likeButton.addTarget(self, action: #selector(clickLike), for: .touchUpInside)
        addSubview(likeButton)
        likeButton.frame = CGRect(x: 0, y: 0, width: 50, height: 15)
    }
    
    @objc func clickLike(_ sender: UIButton) {
        isLiked = !isLiked
        if isLiked {
            countLike+=1
            sender.setTitle("\(countLike)", for: .normal)
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            countLike-=1
            sender.setTitle("\(countLike)", for: .normal)
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}

