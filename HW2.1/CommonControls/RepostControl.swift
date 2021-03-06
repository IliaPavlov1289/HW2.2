//
//  RepostControl.swift
//  HW2.1
//
//  Created by Илья Павлов on 24.01.2021.
//

import UIKit

class RepostControl: UIControl {
      
    var countRepost: Int = 0
    var isReposted: Bool = false
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        repostButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        repostButton()
    }
    
    private func repostButton(){
        let repostButton = UIButton(type: .custom)
        repostButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        repostButton.setTitle("\(countRepost)", for: .normal)
        repostButton.setTitleColor(.black, for: .normal)
        repostButton.tintColor = .blue
        repostButton.contentHorizontalAlignment = .left
        repostButton.addTarget(self, action: #selector(clickRepost), for: .touchUpInside)
        addSubview(repostButton)
        repostButton.frame = CGRect(x: 0, y: 0, width: 50, height: 15)
    }
    
    @objc func clickRepost(_ sender: UIButton) {
        isReposted = !isReposted
        if isReposted {
            countRepost+=1
            sender.setTitle("\(countRepost)", for: .normal)
            sender.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        } else {
            countRepost-=1
            sender.setTitle("\(countRepost)", for: .normal)
            sender.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        }
    }
}
