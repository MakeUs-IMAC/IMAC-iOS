//
//  SearchViewModel.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import Foundation
import RxSwift
import Moya

class SearchViewModel {
    let disposeBag = DisposeBag()
    var list: [GetPosts] = []
    let provider = MoyaProvider<PostAPI>()
    let userId = UserDefaults.standard.integer(forKey: "id")
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let cellDidTap: Observable<IndexPath>
        let searchText: Observable<String>
    }
    
    struct Output {
        let goToDetailCell = PublishSubject<GetPosts>()
    }
    
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        input.viewWillAppearEvent
            .subscribe(onNext: {
                //get info
                self.getPosts()
            }).disposed(by: disposeBag)
        
        input.cellDidTap.subscribe(onNext: { index in
            // 데이터 전달 list[index.row]
            output.goToDetailCell.onNext(self.list[index.row])
        }).disposed(by: disposeBag)
        
        return output
    }
    
    func getPosts(){
        self.provider.rx.request(.getPost(userId: 4))
            .filterSuccessfulStatusCodes()
            .map(CommonGetPosts.self)
            .asObservable()
            .subscribe(onNext: { item in
                self.list = item.result
//                print(self.list)
                //self.list = item
            }).disposed(by: disposeBag)
        
    }
    
}
