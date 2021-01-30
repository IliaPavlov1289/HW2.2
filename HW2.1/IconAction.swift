//
//  IconAction.swift
//  HW2.1
//
//  Created by Илья Павлов on 29.01.2021.
//

import UIKit

class IconAction: UIView{

    lazy var tapGestureRecogniser: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()

    @objc func onTap(){
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.8
        animation.stiffness = 100
        animation.mass = 1
        animation.autoreverses = true
        
        self.layer.add(animation, forKey: nil)
        

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(tapGestureRecogniser)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addGestureRecognizer(tapGestureRecogniser)
    }
    
}
