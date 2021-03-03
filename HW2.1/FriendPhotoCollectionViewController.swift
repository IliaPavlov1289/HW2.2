//
//  FrendFotoCollectionViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 08.01.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendPhotoCollectionViewController: UICollectionViewController {
    
    var userID = 0.0
    
    var photos: [PhotoSizes]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(userID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let token = Session.shared.token
        
        NetworkManager.loadUserPhotos(token: token, userID: userID) { [weak self] (Photos) in

            self?.photos = Photos
            
            self?.collectionView.reloadData()
        }

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FriendFotoCollectionViewCell{
            cell.downLoadImage(from: photos?[indexPath.row].sizes[0].photoUrl ?? "")
            return cell
            
        }
    
        return UICollectionViewCell()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let indexPath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell) {
            if segue.identifier == "showPhoto"{

                let previewPhoto: PreviewPhotoViewController = segue.destination as! PreviewPhotoViewController

                previewPhoto.indexPhoto = indexPath.row
                previewPhoto.photos = self.photos ?? []
            }
        }
    }

}
