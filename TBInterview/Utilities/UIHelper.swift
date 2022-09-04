//
//  UIHelper.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 8/22/22.
//

import UIKit

enum UIHelper {
    
    static func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 8
        let availableWidth = width - (padding * 2)
        let itemWidth = availableWidth
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 75)
        flowLayout.minimumLineSpacing = 16
        
        return flowLayout
    }
}
