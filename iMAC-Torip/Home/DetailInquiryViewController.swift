//
//  DetailInquiryViewController.swift
//  iMAC-Torip
//
//  Created by 김지훈 on 2022/05/21.
//

import UIKit
import SDWebImage

class DetailInquiryViewController: UIViewController {
    
    @IBOutlet weak var travelRepresentativeImage: UIImageView!
    @IBOutlet weak var travelRouteCollectionView: UICollectionView!
    @IBOutlet weak var travelRouteCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var travelMemberCountLabel: UILabel!
    @IBOutlet weak var travelMemberCountResultLabel: UILabel!
    @IBOutlet weak var travelDescriptionContentLabel: UILabel!
    @IBOutlet weak var travelDescriptionLabel: UILabel!
    @IBOutlet weak var applicantsTableView: UITableView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    let viewModel = DetailInquiryViewModel()
    var detailInquiryData = DetailInquiryViewModel().info
    var applicantsMemberId = [Int]()
    
    @IBAction func pressApplyButon(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pressLikeButton(_ sender: Any) {
        likeButton.setImage( UIImage(named: "selectedHeart"), for: .normal)
    }
    
    override func viewDidLoad() {
        travelRouteCollectionView.delegate = self
        travelRouteCollectionView.dataSource = self
        applicantsTableView.delegate = self
        applicantsTableView.dataSource = self
        viewModel.checkPresenceOfProfile()
        let destinationCellNib = UINib(nibName: "TravelRouteCollectionViewCell", bundle: nil)
        travelRouteCollectionView.register(destinationCellNib, forCellWithReuseIdentifier: "TravelRouteCollectionViewCell")
        let arrowCellNib = UINib(nibName: "TravelRouteArrowCollectionViewCell", bundle: nil)
        travelRouteCollectionView.register(arrowCellNib, forCellWithReuseIdentifier: "TravelRouteArrowCollectionViewCell")
        //        let participantNib = UINib(nibName: "ParticipantTableViewCell", bundle: nil)
        //        applicantsTableView.register(participantNib, forCellWithReuseIdentifier: "ParticipantTableViewCell")
        
        applicantsTableView.register(UINib(nibName: "ParticipantTableViewCell", bundle: nil), forCellReuseIdentifier: "ParticipantTableViewCell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            print("Q", self.viewModel.info)
            print("!!!", self.viewModel.info?.result.placeDtos[0].addressDtos[0].address)
            self.initialSetup()
            self.travelRouteCollectionView.reloadData()
            self.applicantsTableView.reloadData()
            self.travelRepresentativeImage.sd_setImage(with: URL(string: (self.viewModel.info?.result.image)!))
        })
        
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
        let participantsNumber = viewModel.info?.result.participants
        travelMemberCountResultLabel.text = "\(participantsNumber!)명"
        travelDescriptionLabel.text = "여행 설명"
        
        travelMemberCountLabel.text = "인원"
        travelDescriptionContentLabel.layer.borderWidth = 1
        travelDescriptionContentLabel.layer.borderColor = UIColor.gray.cgColor
        travelDescriptionContentLabel.layer.cornerRadius = 10
        travelDescriptionContentLabel.text = viewModel.info?.result.content
        
    }
}

extension DetailInquiryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.info?.result.placeDtos.count ?? 0
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
        let destinationNumber = viewModel.info?.result.placeDtos[section].addressDtos.count
        return destinationNumber! * 2 - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TravelRouteCollectionViewCell", for: indexPath) as! TravelRouteCollectionViewCell
        let arrowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TravelRouteArrowCollectionViewCell", for: indexPath) as! TravelRouteArrowCollectionViewCell
        
        cell.destinationAddress.text = viewModel.info?.result.placeDtos[indexPath.section].addressDtos[indexPath.item/2].address
        cell.destinationName.text = viewModel.info?.result.placeDtos[indexPath.section].addressDtos[indexPath.item/2].name
        cell.destinationName.font = UIFont.systemFont(ofSize:15)
        cell.destinationAddress.font = UIFont.systemFont(ofSize:8)
        cell.destinationAddress.tintColor = UIColor.gray
        
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
        //        let width = travelRouteCollectionView.frame.size.width / 7
        //        return CGSize(width: width, height: cellSize)
        return CGSize(width: cellSize, height: cellSize)
    }
}

extension DetailInquiryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let applicantNumber = viewModel.info?.result.applicantsDtos.count
        return applicantNumber ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applicantsTableView.dequeueReusableCell(withIdentifier: "ParticipantTableViewCell", for: indexPath) as! ParticipantTableViewCell
        let applicants = viewModel.info?.result.applicantsDtos[indexPath.row]
        if viewModel.info?.result.driverFlag == 1 {
            cell.nickNameLabel.text = applicants?.nickName
            cell.additionalInfoLabel.text = applicants?.carType
            return cell
        }
        if applicants!.role == "Driver" && applicantsMemberId.contains(applicants!.memberId) {
            applicantsMemberId.append(applicants!.memberId)
            cell.nickNameLabel.text = applicants?.nickName
            cell.additionalInfoLabel.text = applicants?.carType
            return cell
        }
        cell.nickNameLabel.text = applicants?.nickName
        cell.additionalInfoLabel.text = "\(applicants?.gender) / \(applicants?.age)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellWidth = applicantsTableView.frame.size.width
        let cellHeight = cellWidth / 6
        return cellHeight
    }
}
