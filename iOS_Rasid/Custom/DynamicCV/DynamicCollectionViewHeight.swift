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
        
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
