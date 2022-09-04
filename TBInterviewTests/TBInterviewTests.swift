//
//  TBInterviewTests.swift
//  TBInterviewTests
//
//  Created by Zachary Rhodes on 5/25/21.
//

import XCTest
@testable import TBInterview

class TBInterviewTests: XCTestCase {
    var expenseCalculationManager: ExpenseCalculationManager!
    var interactor: Interactor!
    
    override func setUp() {
        super.setUp()
        expenseCalculationManager = ExpenseCalculationManager()
        interactor = Interactor(api: API())
    }
    
    override func tearDown() {
        super.tearDown()
        expenseCalculationManager = nil
        interactor = nil
    }
    
    func testExpenseCalculationManager() throws {
        let accuracy: Float = 0.0001
        
        var expenses = loadJSON(fromFile: "expenses1")
        var totalMonthlySpent = expenseCalculationManager.calculateTotalMonthlySpent(for: expenses)
        var mostSpentCategory = expenseCalculationManager.findMostSpentCategory(for: expenses)
        XCTAssertEqual(totalMonthlySpent, 1141, accuracy: accuracy)
        XCTAssertTrue(mostSpentCategory == "software")
        
        expenses = loadJSON(fromFile: "expenses2")
        totalMonthlySpent = expenseCalculationManager.calculateTotalMonthlySpent(for: expenses)
        mostSpentCategory = expenseCalculationManager.findMostSpentCategory(for: expenses)
        XCTAssertEqual(totalMonthlySpent, 1413, accuracy: accuracy)
        XCTAssertTrue(mostSpentCategory == "travel")
        
        expenses = loadJSON(fromFile: "expenses3")
        totalMonthlySpent = expenseCalculationManager.calculateTotalMonthlySpent(for: expenses)
        mostSpentCategory = expenseCalculationManager.findMostSpentCategory(for: expenses)
        XCTAssertEqual(totalMonthlySpent, 1251, accuracy: accuracy)
        XCTAssertTrue(mostSpentCategory == "food")
    }
    
    private func loadJSON(fromFile filename: String) -> [Expense] {
        guard let path = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON file.")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode([Expense].self, from: data)
            
            return decodedObject
        } catch {
            print("❌ \(error)")
            fatalError("Failed to decode the JSON.")
        }
    }
}
