//
//  CommentsControl.swift
//  HW2.1
//
//  Created by Илья Павлов on 24.01.2021.
//

import UIKit

class CommentsControl: UIControl {
    
    var commentButton = UIButton(type: .custom)
      
    var countComments: Int = 0 {
        didSet {
            setCount()
        }
    }
    var isComment: Bool = false
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton(){
        commentButton.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        commentButton.setTitle("\(countComments)", for: .normal)
        commentButton.setTitleColor(.black, for: .normal)
        commentButton.tintColor = .blue
        commentButton.contentHorizontalAlignment = .left
        commentButton.addTarget(self, action: #selector(commentClick), for: .touchUpInside)
        addSubview(commentButton)
        commentButton.frame = CGRect(x: 0, y: 0, width: 50, height: 15)
    }
    
    @objc func commentClick(_ sender: UIButton) {
        isComment = !isComment
        if isComment {
            countComments+=1
            sender.setTitle("\(countComments)", for: .normal)
        } else {
            countComments-=1
            sender.setTitle("\(countComments)", for: .normal)
        }
    }
    
    private func setCount() {
        commentButton.setTitle("\(countComments)", for: .normal)
    }
    
}
