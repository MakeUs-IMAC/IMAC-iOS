//
//  SearchViewController.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import UIKit
import RxSwift
import RxCocoa

//struct HomeCell: Hashable {
//    var id = UUID()
//    var imageURL: String
//    var title: String
//    var date: String
//    var count: Int
//}

class SearchViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    private var section = 0
    var dataSource: UITableViewDiffableDataSource<Int, GetPosts>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Int, GetPosts>! = nil

    var viewModel: SearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureDataSource()
        viewModel = SearchViewModel()
        viewModel?.list = list
        searchBar.delegate = self
        tableView.delegate = self
    }
    
    private func configureDataSource() {
        tableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        dataSource = UITableViewDiffableDataSource<Int, GetPosts>(tableView: tableView) { (tableView, indexPath, item) -> HomeTableViewCell? in let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
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
        let input = SearchViewModel.Input(viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in }, textBeginChanging: self.searchBar.rx.textDidBeginEditing.asObservable(), cellDidTap: self.tableView.rx.itemSelected.asObservable(), searchText: self.searchBar.rx.text.orEmpty.asObservable())

        let output = viewModel?.transform(from: input, disposeBag: viewModel?.disposeBag ?? self.disposeBag)
        output?.goToDetailCell
            .subscribe(onNext: { item in
                self.goToDetail(item: item)
            }).disposed(by: disposeBag)
    }
    
}

extension SearchViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = list[indexPath.row]
        self.goToDetail(item: list)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}

extension SearchViewController {
    func goToDetail(item: HomeCell) {
        let detailVC = UIStoryboard(name: "Home", bundle: nil)
        let vc = detailVC.instantiateViewController(withIdentifier: "DetailInquiryViewController") as! DetailInquiryViewController
       // detailVC.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
