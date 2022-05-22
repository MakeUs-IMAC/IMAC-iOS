//
//  UserRole.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import Foundation
enum UserRole:String, CaseIterable{
    case traveler = "여행자"
    case driver = "운전자"
    
    var englishRawValue: String{
        switch self {
        case .traveler:
            return "TRAVELER"
        case .driver:
            return "DRIVER"
        }
    }
}
