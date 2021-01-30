//
//  LoaderViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 27.01.2021.
//

import UIKit

class LoaderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let lay = CAReplicatorLayer()
        lay.frame = view.frame
        lay.backgroundColor = UIColor.white.cgColor
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        circle.position = CGPoint(x: view.center.x - 50, y: view.center.y)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor.blue.cgColor
        lay.addSublayer(circle)
        lay.instanceCount = 3
        lay.instanceTransform = CATransform3DMakeTranslation(50, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.0
        anim.duration = 0.7
        anim.autoreverses = true
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
         
        view.layer.addSublayer(lay)
    }
}
