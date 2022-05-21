//
//  DetailInquiry.swift
//  iMAC-Torip
//
//  Created by 김지훈 on 2022/05/21.
//

import Foundation

struct DetailInquiry {
    let travelDestinations: [TravelDestination]
}

struct TravelDestination {
    var destinationName: String
    var destinationAddress: String
}
