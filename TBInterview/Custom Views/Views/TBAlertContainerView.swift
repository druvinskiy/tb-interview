//
//  TBAlertContainerView.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 9/3/22.
//

import UIKit

class TBAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
