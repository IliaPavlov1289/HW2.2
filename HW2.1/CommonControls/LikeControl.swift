//
//  LikeControl.swift
//  HW2.1
//
//  Created by Илья Павлов on 14.01.2021.
//

import UIKit

class LikeControl: UIControl {
    
    var likeButton = UIButton(type: .custom)
      
    var countLike: Int = 0 {
        didSet {
            setCount()
        }
    }
    
    var isLiked: Bool = false

 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton(){
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
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            countLike-=1
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        UIView.transition(with: sender,
                          duration: 0.25,
                          options: .transitionFlipFromLeft,
                          animations: {sender.setTitle("\(self.countLike)", for: .normal)
                          })
    }
    
    private func setCount() {
        likeButton.setTitle("\(countLike)", for: .normal)
    }
}

