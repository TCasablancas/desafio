//
//  String+Extension.swift
//  GitRepo
//
//  Created by Thyago on 30/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

extension String {
    func convertToNumber() -> NSDecimalNumber? {
        guard self.count > 3 else { return nil }
        let str = self
        let status = str.last
        var number = String(str.dropLast())
//        numer.insert(",", at: number.index(number.endIndex, offsetBy: -2))
        let locale = Locale(identifier: "pt_BR")
        let decimalNumber = NSDecimalNumber(string: number, locale: locale)
        
        guard status == "+" else {
            let negative = NSDecimalNumber(string: "-1.0")
            return decimalNumber.multiplying(by: negative)
        }
        
        return NSDecimalNumber(string: number, locale: locale)
    }
}
