//
//  DetailViewController.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import UIKit
import RxSwift
import RxCocoa
import PhotosUI

class DetailViewController: UIViewController {
    let area = ["서울", "제주", "부산", "경기", "인천", "대전", "대구", "광주", "충북", "강원", "전남", "전북", "경남", "경북", "울산", "충남"]
    let disposeBag = DisposeBag()
    enum Section {
        case place, add
    }
    @IBOutlet weak var areaCollectionView: UICollectionView!
    @IBOutlet weak var placeCollectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var isNeedDriver: UISwitch!
    @IBOutlet weak var driverCount: UIStepper!
    @IBOutlet weak var userCount: UIStepper!
    
    @IBOutlet weak var moreInfoText: UITextView!
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
