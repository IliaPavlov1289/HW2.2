//
//  PreviewPhotoViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 31.01.2021.
//

import UIKit

class PreviewPhotoViewController: UIViewController {
    let fotos = ["friendFoto1", "Учёный", "friendFoto1", "Учёный", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1"]

    
    @IBOutlet weak var prevPreviewPhoto: UIImageView!
    
    @IBOutlet private weak var previewPhoto: UIImageView!
    
    @IBOutlet weak var nextPreviewPhoto: UIImageView!
    
    var prevPhoto: UIImage?
    var nextPhoto: UIImage?
    var currentPhoto: UIImage?
    var indexPhoto: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prevPreviewPhoto.transform = CGAffineTransform(translationX: -view.frame.width, y: 0)
        nextPreviewPhoto.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        if indexPhoto > 0 {
        prevPhoto = UIImage(named:fotos[indexPhoto - 1])
        } else {
            prevPhoto = nil
        }
        if indexPhoto < fotos.count - 1 {
        nextPhoto = UIImage(named:fotos[indexPhoto + 1])
        } else {
            nextPhoto = nil
        }
        
        self.previewPhoto.image = currentPhoto
        self.prevPreviewPhoto.image = prevPhoto
        self.nextPreviewPhoto.image = nextPhoto
        
    }
    
    @objc func handleSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .left && indexPhoto < fotos.count - 1 {
                animationSwipeLeft()
            } else if swipeGesture.direction == .right && indexPhoto > 0 {

                animationSwipeRight()
            }
//            self.previewPhoto.image = UIImage(named:fotos[indexPhoto])
//            self.prevPreviewPhoto.image = UIImage(named:fotos[indexPhoto - 1])
        }
    }
    
    func animationSwipeRight(){
        UIView.animate(withDuration: 0.5,
                                delay: 0,
                                options:[],
                                animations: {
                                    self.prevPreviewPhoto.transform = CGAffineTransform(translationX: 0, y: 0)
                                    self.previewPhoto.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                                },
                                completion: {
                                    (isFinished) in
                                    if isFinished {
                                        self.indexPhoto -= 1
                                        self.previewPhoto.image = UIImage(named:self.fotos[self.indexPhoto])
                                        if self.indexPhoto > 0 {
                                            self.prevPreviewPhoto.image = UIImage(named:self.fotos[self.indexPhoto - 1])
                                        }else{
                                            self.prevPreviewPhoto.image = nil
                                            
                                        }
                                        self.nextPreviewPhoto.image = UIImage(named:self.fotos[self.indexPhoto + 1])
                                        self.previewPhoto.transform = .identity
                                        self.prevPreviewPhoto.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                                    }
                                })
    }
    
    func animationSwipeLeft(){
        UIView.animate(withDuration: 0.5,
                                delay: 0,
                                options:[],
                                animations: {
                                    self.nextPreviewPhoto.transform = CGAffineTransform(translationX: 0, y: 0)
                                    self.previewPhoto.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                                },
                                completion: {
                                    (isFinished) in
                                    if isFinished {
                                        self.indexPhoto += 1
                                        self.previewPhoto.image = UIImage(named:self.fotos[self.indexPhoto])
                                        self.prevPreviewPhoto.image = UIImage(named:self.fotos[self.indexPhoto - 1])
                                        if self.indexPhoto < self.fotos.count - 1 { self.nextPreviewPhoto.image = UIImage(named:self.fotos[self.indexPhoto + 1])
                                        }else{
                                            self.nextPreviewPhoto.image = nil
                                        }
                                        self.previewPhoto.transform = .identity
                                        self.nextPreviewPhoto.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
                                    }
                                })
    }
    
}
