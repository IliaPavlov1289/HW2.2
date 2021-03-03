//
//  PreviewPhotoViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 31.01.2021.
//

import UIKit

class PreviewPhotoViewController: UIViewController {
    var photos: [PhotoSizes]? = []

    
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
            self.downLoadPrevPreviewPhotoImage(from: photos?[indexPhoto - 1].sizes.last?.photoUrl ?? "")
        } else {
            self.prevPreviewPhoto.image = nil
        }
        if indexPhoto < (photos?.count ?? 1) - 1 {
            self.downLoadNextPreviewPhotoImage(from: photos?[indexPhoto + 1].sizes.last?.photoUrl ?? "")
        } else {
            self.nextPreviewPhoto.image = nil
        }
        
        self.downLoadPreviewPhotoImage(from: photos?[indexPhoto].sizes.last?.photoUrl ?? "")
        
    }
    
    @objc func handleSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .left && indexPhoto < (photos?.count ?? 1) - 1 {
                animationSwipeLeft()
            } else if swipeGesture.direction == .right && indexPhoto > 0 {

                animationSwipeRight()
            }
            
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
                                        self.downLoadPreviewPhotoImage(from: self.photos?[self.indexPhoto].sizes.last?.photoUrl ?? "")
                                        if self.indexPhoto > 0 {
                                            self.downLoadPrevPreviewPhotoImage(from: self.photos?[self.indexPhoto - 1].sizes.last?.photoUrl ?? "")
                                        }else{
                                            self.prevPreviewPhoto.image = nil
                                            
                                        }
                                        self.downLoadNextPreviewPhotoImage(from: self.photos?[self.indexPhoto + 1].sizes.last?.photoUrl ?? "")
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
                                        self.downLoadPreviewPhotoImage(from: self.photos?[self.indexPhoto].sizes.last?.photoUrl ?? "")
                                        self.downLoadPrevPreviewPhotoImage(from: self.photos?[self.indexPhoto - 1].sizes.last?.photoUrl ?? "")
                                        if self.indexPhoto < (self.photos?.count ?? 1) - 1 { self.downLoadNextPreviewPhotoImage(from: self.photos?[self.indexPhoto + 1].sizes.last?.photoUrl ?? "")
                                        }else{
                                            self.nextPreviewPhoto.image = nil
                                        }
                                        self.previewPhoto.transform = .identity
                                        self.nextPreviewPhoto.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
                                    }
                                })
    }
    
    func downLoadPreviewPhotoImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                let uiImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.previewPhoto.image = uiImage
                }
                
            }
        }.resume()
    }
    
    func downLoadPrevPreviewPhotoImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                let uiImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.prevPreviewPhoto.image = uiImage
                }
                
            }
        }.resume()
    }
    
    func downLoadNextPreviewPhotoImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                let uiImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.nextPreviewPhoto.image = uiImage
                }
                
            }
        }.resume()
    }
}
