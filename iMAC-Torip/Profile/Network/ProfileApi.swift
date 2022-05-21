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
    
    var baseURL: URL{
        return URL(string: "https://jinbeom.shop")!
    }
    
    var path: String{
        switch self {
        case .checkPresenceOfProfile:
            return "/\(UserDefaults.standard.integer(forKey: "id"))"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .checkPresenceOfProfile:
            return .get
        }
    }
    
    var task: Task{
        switch self {
        case .checkPresenceOfProfile:
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        return ["x-access-token":UserDefaults.standard.string(forKey: "token")!]
    }
}


