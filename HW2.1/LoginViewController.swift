//
//  ViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 20.12.2020.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var paswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapOnScroll))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keybosrdWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybosrdWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let result =  checkUserCredentials()
        if !result {
            showAlert()
        }
        return result
    }
    
    @objc func keybosrdWillShow(notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.size.height, right: 0)
        scrollView.contentInset = insets
    }
    
    func checkUserCredentials() -> Bool {
        return loginTextField.text! == "admin" && paswordTextField.text! == "123"
    }
    func showAlert () {
        let alert = UIAlertController(title: "Error", message: "Введён неверный логин или пароль", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }

    @objc func keybosrdWillHide(notification: Notification) {
        let insets = UIEdgeInsets.zero
        scrollView.contentInset = insets
    }
    
    @objc func didtapOnScroll() {
        view.endEditing(true)
    }
    
    @IBAction func didTabButton(_ sender: UIButton) {
        
        
        
//        let layer = CAShapeLayer()
//        layer.bounds = view.bounds
//        layer.backgroundColor = UIColor.white.cgColor
//        layer.position = CGPoint(x: view.center.x, y: view.center.y)
//        view.layer.addSublayer(layer)
//
//        let circleLayer1 = CAShapeLayer()
//        circleLayer1.backgroundColor = UIColor.blue.cgColor
//        circleLayer1.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
//        circleLayer1.position = CGPoint(x: view.center.x, y: view.center.y)
//        circleLayer1.cornerRadius = 10
//
//        let circleLayer2 = circleLayer1
//        circleLayer2.position.x = view.center.x - 50
//
//        let circleLayer3 = circleLayer1
//        circleLayer3.position.x = view.center.x + 50
//
//        view.layer.addSublayer(circleLayer1)
//        view.layer.addSublayer(circleLayer2)
//        view.layer.addSublayer(circleLayer3)
//
//        print(layer.frame.size.height)
//        print(containerView.frame.size.height)
//
    }
    
    
    
}

