//
//  DynamicCollectionViewHeight.swift
//  iOS_Rasid
//
//  Created by Fintech on 20/11/2022.
//

import Foundation


import UIKit

class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
