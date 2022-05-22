//
//  HomeViewController.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingButton: UIButton!
    @IBAction func floating() {
        self.goToWrite()
    }
    let disposeBag = DisposeBag()
    var dataSource: UITableViewDiffableDataSource<Int, GetPosts>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Int, GetPosts>! = nil
 
    var viewModel = HomeViewModel()
    private var section = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 55
        viewModel = HomeViewModel()
        bindViewModel()
        DispatchQueue.main.asyncAfter (deadline: .now() + .seconds(2)) {
            self.configureDataSource()
        }
        floatingButton.makeCircleShape()
        tableView.delegate = self
    }
    
    private func configureDataSource() {
        tableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        dataSource = UITableViewDiffableDataSource<Int, GetPosts>(tableView: tableView) { (tableView, indexPath, item) -> HomeTableViewCell? in let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
            cell.titleLabel.text = item.region
            cell.placeLabel.text = "\(item.start) 부터 \(item.end)까지"
            cell.palceImageView.sd_setImage(with: URL(string: item.image))
            cell.countButton.setTitle("\(item.participants)명", for: .normal)
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
        // 빈 snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Int, GetPosts>()
        snapshot.appendSections([section])
        section += 1
        snapshot.appendItems(viewModel.list)
        dataSource.apply(snapshot)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) 
    }
    
    
    func bindViewModel() {
        let input = HomeViewModel.Input(viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in }, floatingButton: self.floatingButton.rx.tap.asObservable(), cellDidTap: self.tableView.rx.itemSelected.asObservable())
        
        let output = viewModel.transform(from: input, disposeBag: viewModel.disposeBag)
        output.goToDetailCell
            .subscribe(onNext: { item in
                self.goToDetail(item: item)
            }).disposed(by: disposeBag)

    }

}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = viewModel.list[indexPath.row]
        self.goToDetail(item: list)
    }
}


extension HomeViewController {
    func goToWrite(){
        let storyBoard = UIStoryboard(name: "Search", bundle: nil)
        let calendar = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        //detailVC.item = item
        self.navigationController?.pushViewController(calendar, animated: true)
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    func goToDetail(item: GetPosts) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailInquiryViewController") as! DetailInquiryViewController
        //detailVC.item = item
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

