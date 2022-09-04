//
//  Expense.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 8/22/22.
//

import Foundation

// MARK: - ExpenseResponse
struct ExpenseResponse: Codable {
    let expenses: [Expense]
}

// MARK: - Expense
struct Expense: Codable, Hashable {
    let title: String
    let category: String?
    let amount: Float
}
