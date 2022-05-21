//
//  AddPlaceCollectionViewCell.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/22.
//

import UIKit

class AddPlaceCollectionViewCell: UICollectionViewCell {
    var addButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
}

extension AddPlaceCollectionViewCell {
    func configureUI(){
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints {
            
        }
    }
}
