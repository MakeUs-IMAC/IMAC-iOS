//
//  DetailInquiry.swift
//  iMAC-Torip
//
//  Created by 김지훈 on 2022/05/21.
//

import Foundation
    struct DetailInquiry: Codable {
        var code: Int
        var isSuccess: Bool
        var message: [String]
        var result: travelResult
    }
    
    struct travelResult: Codable {
        var applicantsDtos: [applicantsDtosResult]
        var content: String
        var driverFlag: Int
        var end: String
        var favoriteCount: Int
        var image: String
        var participants: Int
        var placeDtos: [placeDtosResult]
        var postId: Int
        var region: String
        var start: String
    }
    
    struct applicantsDtosResult: Codable {
        var age: Int
        var carType: String
        var gender: String
        var memberId: Int
        var nickName: String
        var rate: Int
        var role: String

    }
    
    struct placeDtosResult: Codable {
        var addressDtos: [addressDtosResult]
        var placeId: Int
    }
    
    struct addressDtosResult: Codable {
        var address: String
        var name: String
    }
