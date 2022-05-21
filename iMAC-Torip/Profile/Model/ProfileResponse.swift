//
//  ProfileResult.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import Foundation
struct ProfileResponse: Codable{
    var result: Result
    
    struct Result: Codable{
        var carType: String
        var gender: String
        var image: String
        var nickName: String
        var phone: String
        var role: String
    }
}
