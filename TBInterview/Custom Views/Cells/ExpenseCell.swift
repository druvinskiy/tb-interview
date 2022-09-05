//
//  ExpenseCell.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 8/22/22.
//

import UIKit

class ExpenseCell: UICollectionViewCell {
    
    static let reuseID = "ExpenseCell"
    
    let titleLabel = TBTitleLabel(textAlignment: .left, fontSize: 18, weight: .bold)
    let categoryLabel = TBSecondaryTitleLabel(fontSize: 14)
    let amountLabel = TBSecondaryTitleLabel(fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func set(expense: Expense) {
        titleLabel.text = expense.title
        categoryLabel.text = expense.category?.capitalized ?? "No category"
        amountLabel.text = expense.amount.toCurrencyFormat()
    }
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubViews(titleLabel, categoryLabel, amountLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
