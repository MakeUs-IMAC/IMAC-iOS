//
//  ProfileApi.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import Foundation
import Moya

enum ProfileApi: TargetType{
    case checkPresenceOfProfile
    case registPorfile(_ profile: Profile)
    var baseURL: URL{
        return URL(string: "https://jinbeom.shop")!
    }
    
    var path: String{
        switch self {
        default:
            return "/member/\(UserDefaults.standard.integer(forKey: "id"))"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .checkPresenceOfProfile:
            return .get
        case .registPorfile(_):
            return .post
        }
    }
    
    var task: Task{
        switch self {
        case .checkPresenceOfProfile:
            return .requestPlain
        case .registPorfile(let profile):
            let parameters: [String: Any] = [
                "age": profile.age,
                "carType": profile.carType,
                "gender": profile.gender,
                "nickName": profile.nickName,
                "phone": profile.phone,
                "role": profile.role
            ]
            return .requestParameters(parameters:parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]?{
        return ["x-access-token": UserDefaults.standard.string(forKey: "token")!]
    }
}


