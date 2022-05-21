//
//  SearchViewModel.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import Foundation
import RxSwift

class SearchViewModel {
    let disposeBag = DisposeBag()
    var list: [GetPosts]
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let textBeginChanging: Observable<Void>
        let cellDidTap: Observable<IndexPath>
        let searchText: Observable<String>
    }
    
    struct Output {
        let goToDetailCell = PublishSubject<GetPosts>()
    }
    
    init() {
      getPosts()
    }
    
    
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        input.viewWillAppearEvent
            .subscribe(onNext: {
                //get info
            }).disposed(by: disposeBag)
        
        input.cellDidTap.subscribe(onNext: { index in
            // 데이터 전달 list[index.row]
            output.goToDetailCell.onNext(self.list[index.row])
        }).disposed(by: disposeBag)
        
        return output
    }
    
}
