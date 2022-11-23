//
//  UIView+Design.swift
//  iOS_Rasid
//
//  Created by Fintech on 22/11/2022.
//

import UIKit

extension UIView {
    
    @IBInspectable var radius: CGFloat {
        get {
            self.radius
        } set {
            self.layer.cornerRadius = newValue
        }
    }
}
