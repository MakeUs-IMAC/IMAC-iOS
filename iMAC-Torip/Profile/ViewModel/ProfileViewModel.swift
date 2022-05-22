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
    var nickname = ""
    var contract = ""
    var role: UserRole = .traveler
    var gender: Gender = .male
    var age: Age = .teen
    var carType: CarType = .compactCar
   
    private var profile: Profile? = nil
    
    func checkPresenceOfProfile(completion: ((Bool, Error?) -> Void)? = nil){
        let provider = MoyaProvider<ProfileApi>()
        
        provider.request(.checkPresenceOfProfile){
            switch $0{
            case let .success(response):
//                print(try! response.mapJSON())
                self.profile = try? response.map(ProfileResponse.self).result
                completion?(self.profile!.nickName != "", nil)
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
    
    func registProfile(completion: ((Bool) -> Void)? = nil){
        let provider = MoyaProvider<ProfileApi>()
        
        provider.request(.registPorfile(Profile(role: role, nickname: nickname, phone: contract, age: age, gender: gender, carType: carType))){
            switch $0{
            case let .success(response):
                if response.statusCode >= 200 && response.statusCode <= 300{
                    completion?(true)
                }
                else{
                    print(response.statusCode)
                    completion?(false)
                }
            case let .failure(error):
                completion?(false)
                print(error.localizedDescription)
            }
        }
    }
}
