//
//  TBTitleLabel.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 8/22/22.
//

import UIKit

class TBTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, weight: UIFont.Weight) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
    
    private func configure() {
        textColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
}
