//
//  OverviewView.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 9/2/22.
//

import UIKit

class OverviewView: UIView {
    
    let categoryEmojiDict = ["travel": "✈️", "food": "🍔", "software": "💻"]
    
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
        addSubViews(monthLabel, spentMostOnLabel, categoryLabel, totalMonthlySpendLabel, amountLabel)
        
        spentMostOnLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        spentMostOnLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        categoryLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        categoryLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        totalMonthlySpendLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        totalMonthlySpendLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        amountLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        amountLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            spentMostOnLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 30),
            spentMostOnLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            spentMostOnLabel.heightAnchor.constraint(equalToConstant: 20),
            
            categoryLabel.leadingAnchor.constraint(equalTo: spentMostOnLabel.trailingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            categoryLabel.centerYAnchor.constraint(equalTo: spentMostOnLabel.centerYAnchor),

            totalMonthlySpendLabel.leadingAnchor.constraint(equalTo: spentMostOnLabel.leadingAnchor),
            totalMonthlySpendLabel.topAnchor.constraint(equalTo: spentMostOnLabel.bottomAnchor, constant: 12),
            
            amountLabel.leadingAnchor.constraint(equalTo: totalMonthlySpendLabel.trailingAnchor, constant: 10),
            amountLabel.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),
            amountLabel.centerYAnchor.constraint(equalTo: totalMonthlySpendLabel.centerYAnchor),
        ])
    }
    
    func set(expenses: [Expense], budget: Float) {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("LLLL")
        let currentMonthName = dateFormatter.string(from: now)
        
        monthLabel.text = "\(currentMonthName) Overview"
        spentMostOnLabel.text = "You spent the most on:"
        totalMonthlySpendLabel.text = "Total monthly spend:"
        
        let mostSpentCategory = ExpensesCalculator.findMostSpentCategory(for: expenses)
        let totalMonthlySpent = ExpensesCalculator.calculateTotalMonthlySpent(for: expenses)
        
        let symbol = categoryEmojiDict[mostSpentCategory] ?? ""
        categoryLabel.text = "\(mostSpentCategory.capitalized) \(symbol)"

        amountLabel.text = totalMonthlySpent.toCurrencyFormat()
        amountLabel.textColor = totalMonthlySpent > budget ? .radical : .bajaBlast
    }
}
