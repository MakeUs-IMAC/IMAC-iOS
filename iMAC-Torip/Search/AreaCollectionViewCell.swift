//
//  AreaCollectionViewCell.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/22.
//

import UIKit
import SnapKit

class AreaCollectionViewCell: UICollectionViewCell {
    static var identifier = "AreaCollectionViewCell"
    
    var titleButton: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        button.setTitleColor(.gray, for: .normal)
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

extension AreaCollectionViewCell {
    func configureUI(){
        contentView.addSubview(titleButton)
        titleButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

