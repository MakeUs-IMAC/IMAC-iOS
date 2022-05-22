//
//  Profile.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import Foundation
struct Profile:Codable{
    var carType: String
    var gender: String
    var image: String
    var nickName: String
    var phone: String
    var role: String
    var age: Int
    
    
    init(role: UserRole, nickname: String, phone: String, age:Age? = nil, gender: Gender? = nil, carType: CarType? = nil){
        self.nickName = nickname
        self.phone = phone
        self.image = ""
        switch role {
        case .traveler:
            self.gender = gender == .male ? "MALE" : "FEMAIL"
            switch age{
            case .teen:
                self.age = 10
            case .twenty:
                self.age = 20
            case .thirty:
                self.age = 30
            default:
                self.age = 0
            }
            self.carType = "X"
            self.role = "TRAVELER"
        case .driver:
            switch carType{
            default:
                self.carType = carType!.englishRawValue
            }
            self.gender = "X"
            self.age = 0
            self.role = "DRIVER"
        }
    }
    
    private enum CodingKeys: String, CodingKey{
        case carType
        case gender
        case nickName
        case phone
        case role
        case age
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        carType = try container.decodeIfPresent(String.self, forKey: .carType) ?? ""
        gender = try container.decodeIfPresent(String.self, forKey: .gender) ?? ""
        nickName = try container.decodeIfPresent(String.self, forKey: .nickName) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        role = try container.decodeIfPresent(String.self, forKey: .role) ?? ""
        age = try container.decodeIfPresent(Int.self, forKey: .age) ?? 0
        image = ""
    }
}
