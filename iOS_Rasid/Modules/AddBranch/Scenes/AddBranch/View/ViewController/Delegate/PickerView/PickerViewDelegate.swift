//
//  PickerViewDelegate.swift
//  iOS_Rasid
//
//  Created by Fintech on 10/11/2022.
//

import UIKit

class PickerViewDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    var titles = [String]()
    let cities = ["الاسكندرية", "القاهرة"]
    let distrect = ["المنطقة الاولى", "المنطقة الثانية"]
    let managers = ["احمد", "محمد"]

var selectedTitle: ((String) -> Void)?
    
    init(titles: [String]) {
        
        self.titles = titles
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        titles.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        let atrributes: [NSAttributedString.Key: Any] = [.font:
                                            Fonts.Cairo.regular.font(size: 16),
            .foregroundColor: Colors.addBranchTitleLabels.color.cgColor]
        return NSAttributedString(string: titles[row], attributes: atrributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTitle?(titles[row])
        pickerView.endEditing(true)
    }
    
}
