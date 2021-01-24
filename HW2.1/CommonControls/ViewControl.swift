//
//  ViewControl.swift
//  HW2.1
//
//  Created by Илья Павлов on 24.01.2021.
//

import UIKit

class ViewControl: UIControl {
      
    var countView: Int = 0
    var isViewed: Bool = false
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewButton()
    }
    
    private func viewButton(){
        let viewButton = UIButton(type: .custom)
        viewButton.setImage(UIImage(systemName: "eye"), for: .normal)
        viewButton.setTitle("\(countView)", for: .normal)
        viewButton.setTitleColor(.black, for: .normal)
        viewButton.tintColor = .blue
        viewButton.contentHorizontalAlignment = .right
        addSubview(viewButton)
        viewButton.frame = CGRect(x: 0, y: 0, width: 50, height: 15)
    }
    

}
