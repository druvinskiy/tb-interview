//
//  Float+Ext.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 9/2/22.
//

import Foundation

extension Float {
    func toCurrencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: self))!
    }
}
