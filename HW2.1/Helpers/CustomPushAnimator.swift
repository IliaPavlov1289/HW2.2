//
//  CustomPushAnimator.swift
//  HW2.1
//
//  Created by Илья Павлов on 04.02.2021.
//

import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
        let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        let π = CGFloat.pi
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(rotationAngle: -π/2)
        destination.view.layer.anchorPoint = CGPoint(x:1, y:0)
        destination.view.layer.position = CGPoint(x:source.view.frame.width, y:0)
        
        
        source.view.layer.anchorPoint = CGPoint(x:0, y:0)
        source.view.layer.position = CGPoint(x:0, y:0)
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                options: []) {
            destination.view.transform = .identity
            source.view.transform = CGAffineTransform(rotationAngle: π/2)
        } completion: { (isFinished) in
            let finishedAndNotCancelled = isFinished && !transitionContext.transitionWasCancelled
            
            if finishedAndNotCancelled{
                source.view.transform = .identity
            }
            transitionContext.completeTransition(isFinished)
        }
    }
    

}
