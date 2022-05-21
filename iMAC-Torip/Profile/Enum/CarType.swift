//
//  CarType.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import Foundation
enum CarType: String, CaseIterable{
    case compactCar = "경차"
    case sedan =  "승용차"
    case suv = "SUV"
    case van = "승합차"
    
    var englishName: String{
        switch self {
        case .compactCar:
            return "SMALL"
        case .sedan:
            return "SEDAN"
        case .suv:
            return "SUV"
        case .van:
            return "VAN"
        }
    }
}
