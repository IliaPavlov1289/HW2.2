//
//  FrendFotoCollectionViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 08.01.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendFotoCollectionViewController: UICollectionViewController {
    
    let fotos = ["friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1", "friendFoto1"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FriendFotoCollectionViewCell{
            cell.friendFotoImage.image = UIImage(named:fotos[indexPath.row])
            
            return cell
        }
    
        return UICollectionViewCell()
    }

}
