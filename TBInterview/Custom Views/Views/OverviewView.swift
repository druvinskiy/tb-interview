//
//  OverviewView.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 9/2/22.
//

import UIKit

class OverviewView: UIView {
    
    let monthLabel = TBTitleLabel(textAlignment: .left, fontSize: 24, weight: .bold)
    let spentMostOnLabel = TBSecondaryTitleLabel(fontSize: 16)
    let totalMonthlySpendLabel = TBSecondaryTitleLabel(fontSize: 16)
    let categoryLabel = TBTitleLabel(textAlignment: .right, fontSize: 18, weight: .regular)
    let amountLabel = TBTitleLabel(textAlignment: .right, fontSize: 18, weight: .regular)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(monthLabel, spentMostOnLabel, totalMonthlySpendLabel, categoryLabel, amountLabel)
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            monthLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            monthLabel.heightAnchor.constraint(equalToConstant: 20),
            
            spentMostOnLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 30),
            spentMostOnLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            spentMostOnLabel.widthAnchor.constraint(equalToConstant: 170),
            spentMostOnLabel.heightAnchor.constraint(equalToConstant: 20),
            
            totalMonthlySpendLabel.topAnchor.constraint(equalTo: spentMostOnLabel.bottomAnchor, constant: 12),
            totalMonthlySpendLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalMonthlySpendLabel.widthAnchor.constraint(equalToConstant: 170),
            totalMonthlySpendLabel.heightAnchor.constraint(equalToConstant: 20),
            
            categoryLabel.leadingAnchor.constraint(equalTo: spentMostOnLabel.trailingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            categoryLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 30),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            
            amountLabel.leadingAnchor.constraint(equalTo: totalMonthlySpendLabel.trailingAnchor, constant: 20),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            amountLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12),
            amountLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(expenses: [Expense], budget: Float) {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let currentMonthName = dateFormatter.string(from: now)
        
        monthLabel.text = "\(currentMonthName) Overview"
        spentMostOnLabel.text = "You spent the most on:"
        totalMonthlySpendLabel.text = "Total monthly spend:"
        
        let expenseCalculationManager = ExpenseCalculationManager()
        let mostSpentCategory = expenseCalculationManager.findMostSpentCategory(for: expenses)
        let totalMonthlySpent = expenseCalculationManager.calculateTotalMonthlySpent(for: expenses)
        
        let symbol = ExpenseCategory.dict[mostSpentCategory] ?? ""
        categoryLabel.text = "\(symbol) \(mostSpentCategory.capitalized)"
        
        amountLabel.text = totalMonthlySpent.toCurrencyFormat()
        amountLabel.textColor = totalMonthlySpent > budget ? .radical : .bajaBlast
    }
}
