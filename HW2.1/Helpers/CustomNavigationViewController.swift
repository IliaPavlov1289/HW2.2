//
//  CustomNavigationViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 04.02.2021.
//

import UIKit

class CustomNavigationViewController: UINavigationController, UINavigationControllerDelegate {
    
    let  interactiveTransition = MyInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        view.backgroundColor = .white
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        switch operation {
        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        case .push:
            interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        default:
            return nil
        }
        
    }
    
}
