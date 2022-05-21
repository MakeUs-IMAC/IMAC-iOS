//
//  ProfileViewModel.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import Foundation
import SwiftUI
import Moya

class ProfileViewModel: ObservableObject{
    private var profile: ProfileResponse.Result? = nil
    
    func checkPresenceOfProfile(completion: ((Bool, Error?) -> Void)? = nil){
        let provider = MoyaProvider<ProfileApi>()
        
        provider.request(.checkPresenceOfProfile){
            switch $0{
            case let .success(response):
                self.profile = try? response.map(ProfileResponse.self).result
                completion?(true, nil)
            case let .failure(error):
                if error.errorCode == 404{
                    completion?(false, nil)
                }
                else{
                    completion?(false, error)
                }
            }
        }
    }
}
