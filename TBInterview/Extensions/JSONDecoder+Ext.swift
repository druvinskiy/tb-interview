//
//  JSONDecoder+Ext.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 9/5/22.
//

import Foundation

extension JSONDecoder {
    static func decode(expensesData: Data) throws -> [Expense] {
        let decoder = JSONDecoder()
        return try decoder.decode([Expense].self, from: expensesData)
    }
}
