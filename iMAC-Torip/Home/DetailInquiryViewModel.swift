//
//  TravelRouteViewModel.swift
//  iMAC-Torip
//
//  Created by 김지훈 on 2022/05/21.
//


import Foundation
import Moya

class DetailInquiryViewModel {
    var info: DetailInquiry?
    var postId: Int?
    
    let provider = MoyaProvider<PostAPI>()
//    func getDetailPostResult() {
//        let provider = MoyaProvider<PostAPI>()
//
//        provider.request(.getDetailPost(postId: (info?.result.postId)!)){ [self](result) in
//            switch result {
//            case let .success(response):
//                let decoder = JSONDecoder()
//                info = try decoder.decode(DetailInquiry.self, from: response.data)
//            case let .failure(error):
//                completion?(false, error)
//            }
//        }
//    }
    
    func checkPresenceOfProfile() {
        provider.request(.getDetailPost(postId: (postId)!)){ [weak self] (result) in
            guard let self = self else { return }
            do {
                switch result {
                case let .success(response):
                    let decoder = JSONDecoder()
                    self.info = try decoder.decode(DetailInquiry.self, from: response.data)
                case let .failure(error):
                    print(error)
                    //completion(false, error)
                }
            }catch(let error) {
                print(error.localizedDescription)
            }
          
        }
        
    }
}
