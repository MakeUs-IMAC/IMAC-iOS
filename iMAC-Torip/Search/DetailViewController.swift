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
    let disposeBag = DisposeBag()
    var sectionCount = 0
    
    struct Area: Hashable {
        var title: String
        var id = UUID()
    }
//    enum Section: CaseIterable {
//        case place, add
//    }
    
    enum Section: CaseIterable {
        case main
    }

    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var areaCollectionView: UICollectionView!
    @IBOutlet weak var placeCollectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var isNeedDriver: UISwitch!
    @IBOutlet weak var driverCountLabel: UILabel!
    @IBOutlet weak var userCountLabel: UILabel!
    @IBOutlet weak var driverCount: UIStepper!
    @IBOutlet weak var userCount: UIStepper!
    @IBOutlet weak var moreInfoText: UITextView!
    @IBOutlet weak var texfield: UITextField!
    var headerView: HeaderView?
    var item = [(Int, String, String)]()
    var section = 0
    var sectionArray = [[(String, String)]]()
    @IBAction func doneButton() {
        self.alertViewController(title: "글 작성 완료", message: "글 작성이 완료 되었습니다.", completion: { str in
            if str == "확인" {
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("get sectionArray \(sectionArray)")
        placeCollectionView.reloadData()
    }
    
    @IBAction func userCountValueChanged(sender: UIStepper) {
         userCountLabel.text = "\(Int(sender.value).description)명"
    }
    
    @IBAction func driverCountValueChanged(sender: UIStepper) {
        driverCountLabel.text = "\(Int(sender.value).description)명"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = placeCollectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeight.constant = height
        self.view.layoutIfNeeded()
    }
    
    private var collectionViewSection = 0
    var area = [String]()
    var areaDataSource: UICollectionViewDiffableDataSource<Section, String>! = nil
    var areaSnapshot: NSDiffableDataSourceSnapshot<Section, String>! = nil
    //var dataSource: UICollectionViewDiffableDataSource<Section, String>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewTouch()
        setupUI()
        area = ["서울", "제주", "부산", "경기", "인천", "대전", "대구", "광주", "충북", "강원", "전남", "전북", "경남", "경북", "울산", "충남"]
        configureAreaDataSource()
       // areaCollectionView.collectionViewLayout = createLayout()
        areaCollectionView.delegate = self
        
        profileImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.cancelsTouchesInView = false
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        collectionviewSetting()
        
        sectionArray = Array(repeating: [(String, String)](), count: sectionCount)
    }
    
    @objc func imageTapped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func configureAreaDataSource() {
        areaCollectionView.register(AreaCollectionViewCell.self, forCellWithReuseIdentifier: AreaCollectionViewCell.identifier)
        areaDataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.areaCollectionView) { (collectionView, indexPath, str) -> UICollectionViewCell? in let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AreaCollectionViewCell.identifier, for: indexPath) as! AreaCollectionViewCell
            cell.titleButton.setTitle( "\(str)", for: .normal)
            cell.titleButton.layer.cornerRadius = 5
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
            snapshot.appendSections([.main])
            snapshot.appendItems(area)
            self.areaDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else { fatalError() }
            headerView.DayLabel.text = "Day \(String(indexPath.section + 1))"
            self.headerView = headerView
            return headerView
        }
    func collectionviewSetting(){
        placeCollectionView.dataSource = self
        placeCollectionView.delegate = self
//        let flowLayout = UICollectionViewFlowLayout()
//        placeCollectionView.collectionViewLayout = flowLayout
//                flowLayout.minimumInteritemSpacing = 0
//                flowLayout.minimumLineSpacing = 0
//        placeCollectionView.isUserInteractionEnabled = true
//
        placeCollectionView.register(AddPlaceCollectionViewCell.self, forCellWithReuseIdentifier: AddPlaceCollectionViewCell.identifier)
        placeCollectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCollectionViewCell.identifier)
        placeCollectionView.register(UINib(nibName: HeaderView.reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
    }

    func scrollViewTouch() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touch))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    func setupUI(){
        driverCount.minimumValue = 1
        driverCount.wraps = true
        driverCount.autorepeat = true
        driverCount.maximumValue = 3
        
        userCount.minimumValue = 1
        userCount.wraps = true
        userCount.autorepeat = true
        userCount.maximumValue = 5
    }
    
    @objc func touch(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

}

extension DetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            let itemProvider = results.first?.itemProvider
            if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self.profileImageView.contentMode = .scaleToFill
                            self.profileImageView.image = image
                        }
                    }
                }
            }
    
        }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return sectionArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionArray[section].count + 1 // addCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = placeCollectionView.dequeueReusableCell(withReuseIdentifier: PlaceCollectionViewCell.identifier, for: indexPath) as! PlaceCollectionViewCell
            cell.backgroundColor = .gray
            cell.layer.cornerRadius = 10
            return cell
        }else {
            let cell = placeCollectionView.dequeueReusableCell(withReuseIdentifier: AddPlaceCollectionViewCell.identifier, for: indexPath) as! AddPlaceCollectionViewCell
            cell.backgroundColor = UIColor(red: 153/256, green: 204/256, blue: 255/256, alpha: 0.7)
            
            if !sectionArray[indexPath.section].isEmpty {
                print(indexPath.section)
                print(indexPath.row)
                cell.titleLabel.text = sectionArray[indexPath.section][indexPath.row - 1].0
                cell.addressLabel.text = sectionArray[indexPath.section][indexPath.row - 1].1
            }
           
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 && collectionView == placeCollectionView {
            let postVC = PostCodeInputViewController()
            postVC.section = section
            self.navigationController?.pushViewController(postVC, animated: true)
        }else {

            let item = collectionView.cellForItem(at: indexPath) as! AreaCollectionViewCell
            item.titleButton.setTitleColor(.blue, for: .normal)

        }
       
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        print("desele")
//        if collectionView == areaCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AreaCollectionViewCell.identifier, for: indexPath) as! AreaCollectionViewCell
//            cell.titleLabel.textColor = .gray
//        }
//    }
    
    

}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width
            let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            let itemsPerRow: CGFloat = 3
            let widthPadding = sectionInsets.left * (itemsPerRow + 1)
            let cellWidth = (width - widthPadding) / itemsPerRow
            if collectionView == placeCollectionView {
                return CGSize(width: cellWidth, height: cellWidth)
            }
        return CGSize(width: 80, height: 30)
           
        }
        
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return sectionInsets.left
    }
}
