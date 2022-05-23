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
    @IBOutlet weak var textField: UITextField!
    
    let disposeBag = DisposeBag()
    private var section = 0
    var dataSource: UITableViewDiffableDataSource<Int, GetPosts>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Int, GetPosts>! = nil

    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        DispatchQueue.main.asyncAfter (deadline: .now() + .seconds(2)) {
            self.configureDataSource()
        }
        textField.delegate = self
        tableView.delegate = self
        self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    @objc func textFieldDidChange(_ sender: Any?) {
        self.performQuery(with: textField.text)
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
    
    func performQuery(with filter: String?) {

        let filtered = viewModel.list.filter { ($0.region.lowercased().hasPrefix(filter?.lowercased() ?? "" ))}
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, GetPosts>()
        snapshot.appendSections([section])
        snapshot.appendItems(filtered)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func bindViewModel() {
        let input = SearchViewModel.Input(viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in }, cellDidTap: self.tableView.rx.itemSelected.asObservable(), searchText: self.textField.rx.text.orEmpty.asObservable())

        let output = viewModel.transform(from: input, disposeBag: viewModel.disposeBag)
     
    }
    
}

extension SearchViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = viewModel.list[indexPath.row]
        self.goToDetail(item: list)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textfil(_ textField: UITextField) {
        self.performQuery(with: textField.text ?? "")
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.performQuery(with: textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

extension SearchViewController {
    func goToDetail(item: GetPosts) {
        let detailVC = UIStoryboard(name: "Home", bundle: nil)
        let vc = detailVC.instantiateViewController(withIdentifier: "DetailInquiryViewController") as! DetailInquiryViewController
       // detailVC.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
