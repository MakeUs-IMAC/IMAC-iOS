//
//  DateParser.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/22.
//

import Foundation
import UIKit

extension Date {
    func date(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddZHH:mm:ss.SSSZ"
        return dateFormatter.date(from: string)!
    }
}
