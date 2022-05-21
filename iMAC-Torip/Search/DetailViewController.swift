//
//  DetailViewController.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import UIKit

class DetailViewController: UIViewController {
    let area = ["서울", "제주", "부산", "경기", "인천", "대전", "대구", "광주", "충북", "강원", "전남", "전북", "경남", "경북", "울산", "충남"]
    
    @IBOutlet weak var areaCollectionView: UICollectionView!
    @IBOutlet weak var placeCollectionView: UICollectionView!
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
