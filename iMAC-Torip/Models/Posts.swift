//
//  Posts.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/22.
//

import Foundation

struct CreatePost {
    var content: String
    var driverFlag: Int
    var end: String
    var image: Data
    var participants: Int
    var places: [TotalPlace]
    var region: String
    var start: String
    var userId: Int
}

struct TotalPlace {
    var places: [CreatePlace]
}

struct CreatePlace {
    var address: String
    var name: String
}
