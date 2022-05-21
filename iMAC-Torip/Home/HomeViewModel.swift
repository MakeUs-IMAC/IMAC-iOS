//
//  HomeViewModel.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    let disposeBag = DisposeBag()
    var list: [HomeCell]
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let floatingButton: Observable<Void>
        let cellDidTap: Observable<IndexPath>
    }
    
    struct Output {
        let goToDetailCell = PublishSubject<HomeCell>()
    }
    
    init(list: [HomeCell]) {
        self.list = list
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
