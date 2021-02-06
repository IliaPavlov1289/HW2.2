//
//  MyInteractivTransition.swift
//  HW2.1
//
//  Created by Илья Павлов on 06.02.2021.
//

import UIKit

final class MyInteractiveTransition: UIPercentDrivenInteractiveTransition{
    
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenPan))
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    var hasStarted = false
    var shouldFinished = false
    
    @objc func handleScreenPan (_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            hasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relatibTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relatibTranslation))
            shouldFinished = progress > 0.2
            update(progress)
        case .ended:
            hasStarted = false
            shouldFinished ? finish() : cancel()
        case .cancelled:
            hasStarted = false
            cancel()
        default:
            return
        }
        
    }
    
}
