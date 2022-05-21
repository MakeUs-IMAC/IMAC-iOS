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

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingButton: UIButton!
    @IBAction func floating() {
        self.goToWrite()
    }
    let disposeBag = DisposeBag()
    var dataSource: UITableViewDiffableDataSource<Int, HomeCell>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Int, HomeCell>! = nil
    var list = [HomeCell(imageURL: "", title: "1", date: "d", count: 1), HomeCell(imageURL: "", title: "2", date: "c", count: 2)]
    var viewModel: HomeViewModel?
    private var section = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        viewModel = HomeViewModel(list: list)
        viewModel?.list = list
        floatingButton.makeCircleShape()
        tableView.delegate = self
    }
    
    private func configureDataSource() {
        tableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        dataSource = UITableViewDiffableDataSource<Int, HomeCell>(tableView: tableView) { (tableView, indexPath, item) -> HomeTableViewCell? in let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
            cell.titleLabel.text = item.title
            cell.placeLabel.text = item.date
            cell.palceImageView.image = UIImage(systemName: "heart.fill")
            cell.countButton.setTitle("\(item.count)명", for: .normal)
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
        // 빈 snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeCell>()
        snapshot.appendSections([section])
        section += 1
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func performQuery(with filter: String?) {
        let filtered = list.filter { ($0.title.hasPrefix(filter ?? "" ))}
        print(filtered)
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeCell>()
        snapshot.appendSections([section])
        snapshot.appendItems(filtered)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input(viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in }, floatingButton: self.floatingButton.rx.tap.asObservable(), cellDidTap: self.tableView.rx.itemSelected.asObservable())

        input.floatingButton
            .subscribe(onNext: {
                self.goToWrite()
            }).disposed(by: disposeBag)
        
        let output = viewModel?.transform(from: input, disposeBag: viewModel?.disposeBag ?? self.disposeBag)
        output?.goToDetailCell
            .subscribe(onNext: { item in
                self.goToDetail(item: item)
            }).disposed(by: disposeBag)
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = list[indexPath.row]
        self.goToDetail(item: list)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
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
    
    func goToDetail(item: HomeCell) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailInquiryViewController") as! DetailInquiryViewController
        //detailVC.item = item
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

