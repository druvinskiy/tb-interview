//
//  TBDataLoadingVC.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 9/2/22.
//

import UIKit

class TBDataLoadingVC: UIViewController {
    
    var containerView = UIView()
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        let animationDuration: CGFloat = 0.25
        let alpha: CGFloat = 0.8
        
        UIView.animate(withDuration: animationDuration) { self.containerView.alpha = alpha }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
        }
    }
}
