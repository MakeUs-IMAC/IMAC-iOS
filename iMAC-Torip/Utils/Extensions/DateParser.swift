//
//  DateParser.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/22.
//

import Foundation
import UIKit

class DateUtil {
    
    static func parserTodate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddZHH:mm:ss.SSSZ"
        return dateFormatter.date(from: string)!
    }
}

extension Date {
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    public var month: Int {
         return Calendar.current.component(.month, from: self)
    }
    
    public var day: Int {
         return Calendar.current.component(.day, from: self)
    }
    
    public var monthName: String {
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM" // format January, February, March, ...
        return nameFormatter.string(from: self)
    }
}
