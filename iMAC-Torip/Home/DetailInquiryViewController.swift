//
//  DetailInquiryViewController.swift
//  iMAC-Torip
//
//  Created by 김지훈 on 2022/05/21.
//

import UIKit

class DetailInquiryViewController: UIViewController {

    @IBOutlet weak var travelRepresentativeImage: UIImageView!
    @IBOutlet weak var travelRouteCollectionView: UICollectionView!
    @IBOutlet weak var travelRouteCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var travelMemberCountLabel: UILabel!
    @IBOutlet weak var travelMemberCountResultLabel: UILabel!
    @IBOutlet weak var travelDescriptionLabel: UILabel!
    @IBOutlet weak var travelDescriptionTextView: UITextView!
    @IBOutlet weak var applicantsTableView: UITableView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBAction func pressLikeButton(_ sender: Any) {
        likeButton.setImage( UIImage(named: "selectedHeart"), for: .normal)
    }
    
    override func viewDidLoad() {
        travelRouteCollectionView.delegate = self
        travelRouteCollectionView.dataSource = self
        
        let destinationCellNib = UINib(nibName: "TravelRouteCollectionViewCell", bundle: nil)
        travelRouteCollectionView.register(destinationCellNib, forCellWithReuseIdentifier: "TravelRouteCollectionViewCell")
        let arrowCellNib = UINib(nibName: "TravelRouteArrowCollectionViewCell", bundle: nil)
        travelRouteCollectionView.register(arrowCellNib, forCellWithReuseIdentifier: "TravelRouteArrowCollectionViewCell")
        initialSetup()
        
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = travelRouteCollectionView.collectionViewLayout.collectionViewContentSize.height
        travelRouteCollectionViewHeight.constant = height
        self.view.layoutIfNeeded()
    }
    
    func initialSetup() {
        travelMemberCountLabel.text = "참여 인원"
        travelMemberCountResultLabel.text = "0명"
        travelDescriptionLabel.text = "여행 설명"
        travelDescriptionTextView.layer.borderWidth = 1
        travelDescriptionTextView.layer.borderColor = UIColor.gray.cgColor
        travelDescriptionTextView.layer.cornerRadius = 10
        
    }
}

extension DetailInquiryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TravelRouteCollectionReusableView", for: indexPath) as! TravelRouteCollectionReusableView
        headerview.headerTitleLabel.text = "Day \(String(indexPath.section + 1))"
        return headerview
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 20
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return count * 2 - 1
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TravelRouteCollectionViewCell", for: indexPath) as! TravelRouteCollectionViewCell
        let arrowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TravelRouteArrowCollectionViewCell", for: indexPath) as! TravelRouteArrowCollectionViewCell

        if indexPath.item % 2 == 0 {
            return cell
        }
        return arrowCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = travelRouteCollectionView.frame.size.width / 5
        if indexPath.item % 2 == 0 {
            return CGSize(width: cellSize, height: cellSize)
        }
        let width = travelRouteCollectionView.frame.size.width / 7
        return CGSize(width: width, height: cellSize)
    }
}
