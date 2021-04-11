//
//  Extensions.swift
//  HW2.1
//
//  Created by Илья Павлов on 08.04.2021.
//

import UIKit

extension UIImageView {
    func downloadImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
