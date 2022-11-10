//
//  RJPickerView.swift
//  iOS_Rasid
//
//  Created by Fintech on 09/11/2022.
//

import UIKit

class RJPickerView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerButton: UIButton!
    @IBOutlet weak var pickerHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let viewNib = Bundle.main.loadNibNamed("\(RJPickerView.self)",
                                               owner: self)
        guard let view = viewNib?.first as? UIView
        else { fatalError("cant load RJPicker view from nib") }
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: self.topAnchor),
                                     view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     view.rightAnchor.constraint(equalTo: self.rightAnchor),
                                     view.leftAnchor.constraint(equalTo: self.leftAnchor)])
        pickerButton.addTarget(self,
                               action: #selector(pickerButtonAction),
                               for: .touchUpInside)
//        pickerView.delegate = self
        configUI()
    }
    
    private func configUI() {
        pickerButton.setImage(Images.pickerButtonIc.image,
                              for: .normal)
//        textField.inputView = pickerView
        
    }
    
    @objc
    private func pickerButtonAction() {
        pickerHeight.constant = 250
        self.contentView?.layoutSubviews()
        print("picker Button tapped")
    }
    
}
