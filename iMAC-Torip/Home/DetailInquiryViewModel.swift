//
//  TravelRouteViewModel.swift
//  iMAC-Torip
//
//  Created by 김지훈 on 2022/05/21.
//

import Foundation

struct DetailInquiryViewModel {
    var travelDestinations: [TravelDestination]
}

extension DetailInquiryViewModel {
    var travelRouteNumberOfSections: Int {
        // days number count
        return travelDestinations.count
    }
    
    
}
