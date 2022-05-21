//
//  Posts.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/22.
//

import Foundation

struct CreatePost: Codable {
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

struct TotalPlace: Codable {
    var places: [CreatePlace]
}

struct CreatePlace: Codable {
    var address: String
    var name: String
}


struct CommonGetPosts: Codable {
    var code: Int
    var isSuccess: Bool
    var message: String
    var result: [GetPosts]
}

struct GetPosts: Codable, Hashable {
    var end: String
    var id: Int
    var image: String
    var participants: Int
    var region: String
    var start: String
}
