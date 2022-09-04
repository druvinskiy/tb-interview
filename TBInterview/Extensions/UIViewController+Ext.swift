//
//  UIViewController+Ext.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 9/3/22.
//

import UIKit

extension UIViewController {
    
    func presentTBAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        
        DispatchQueue.main.async {
            let alertVC = TBAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
