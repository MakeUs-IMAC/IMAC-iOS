//
//  PlaceCollectionViewCell.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/22.
//

import UIKit
import SnapKit

class PlaceCollectionViewCell: UICollectionViewCell {
    static var identifier = "PlaceCollectionViewCell"

    var addLabel: UILabel = {
        var label = UILabel()
        label.text = "+"
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    
}

extension PlaceCollectionViewCell {
    func configureUI(){
        contentView.addSubview(addLabel)
        addLabel.snp.makeConstraints { make in
            //make.leading.top.bottom.trailing.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
    }
}
