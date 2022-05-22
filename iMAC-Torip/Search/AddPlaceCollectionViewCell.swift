//
//  AddPlaceCollectionViewCell.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/22.
//

import UIKit

class AddPlaceCollectionViewCell: UICollectionViewCell {
    static var identifier = "AddPlaceCollectionViewCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
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

extension AddPlaceCollectionViewCell {
    
    func configureUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(addressLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(15)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(10)
        }
    }
}
