//
//  HeaderView.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/22.
//


import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HeaderView: UICollectionReusableView {
    static let reuseIdentifier: String = "HeaderView"
    lazy var DayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        return label
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(DayLabel)
        DayLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        
    }
    
}
