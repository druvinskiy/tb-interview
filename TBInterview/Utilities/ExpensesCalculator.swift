//
//  ExpensesCalculator.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 9/1/22.
//

import Foundation

class ExpensesCalculator {
    static func findMostSpentCategory(for expenses: [Expense]) -> String {
        var categorySpendings = [String: Float]()
        
        for expense in expenses {
            guard let category = expense.category else { continue }
            categorySpendings[category] = categorySpendings[category, default: 0] + expense.amount
        }
        
        return categorySpendings.max { a, b in a.value < b.value }!.key
    }
    
    static func calculateTotalMonthlySpent(for expenses: [Expense]) -> Float {
        return expenses.map { $0.amount }.reduce(0, +)
    }
}
