//
//  FilterCustomViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 21/11/2022.
//

import UIKit

class FilterCustomViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var branchNameTextField: UITextField!
    @IBOutlet weak var branchManagerTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var textFieldContainerViews: [UIView]!
    
    var buttonTappedCallback: ((Branch.Filter) -> Void)?
    let pickerView = UIPickerView()
    let datePickerView = UIDatePicker()
    var pickerTitles = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        tapGesture.delegate = self
        
     }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
}

extension FilterCustomViewController {
    
    private func configUI() {
        
        alertView.layer.cornerRadius = 10
        textFieldContainerViews.forEach { view in
            view.layer.cornerRadius = 8
        }
        
        configSearchButton()
        
        configTitleLabelsAndTextFieldPlaceholderStrings()
                
        configDatePickerView()
    }
    
    private func configSearchButton() {
        
        searchButton.layer.cornerRadius = 7
        searchButton.addTarget(self,
                               action: #selector(searchButtonAction),
                               for: .touchUpInside)
        
    }
    
    private func configDatePickerView() {
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        
        datePickerView.addTarget(self,
                                 action: #selector(datePickerAction),
                                 for: .valueChanged)
        
    }
    
    @objc
    private func datePickerAction() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if fromTextField.isFirstResponder {
            fromTextField.text = dateFormatter.string(from: datePickerView.date)
            fromTextField.resignFirstResponder()
        } else if toTextField.isFirstResponder {
            toTextField.text = dateFormatter.string(from: datePickerView.date)
            toTextField.resignFirstResponder()
        }
    }
    
    private func configTitleLabelsAndTextFieldPlaceholderStrings() {
        
        branchManagerTextField.delegate = self
        branchNameTextField.delegate = self
        branchManagerTextField.inputView = pickerView
//                dataTextFields[Fields.branchName.rawValue].inputView = pickerView
        fromTextField.inputView = datePickerView
        toTextField.inputView = datePickerView
    }
    
    @objc
    func searchButtonAction() {
        print("buttonTapped")
        
        let data = Branch.Filter(branchName: branchNameTextField.text ?? "",
                                 managerName: branchManagerTextField.text ?? "",
                                 from: fromTextField.text ?? "",
                                 to: toTextField.text ?? "")
        buttonTappedCallback?(data)
        
        dismiss(animated: true)
    }
    
}

extension FilterCustomViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if branchNameTextField.isFirstResponder {
            pickerTitles = ["الفرع الاول", "الفرع الثانى"]
            pickerView.reloadAllComponents()
            
        } else if branchManagerTextField.isFirstResponder {
        
            pickerTitles = ["محمد", "احمد"]
            pickerView.reloadAllComponents()
        }

    }
}

extension FilterCustomViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return pickerTitles.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        let atrributes: [NSAttributedString.Key: Any] = [.font:
                                                            Fonts.Cairo.regular.font(size: 16),
                                                         .foregroundColor: Colors.addBranchTitleLabels.color.cgColor]
        return NSAttributedString(string: pickerTitles[row], attributes: atrributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if branchManagerTextField.isFirstResponder {
            branchManagerTextField.text = pickerTitles[row]
            branchManagerTextField.resignFirstResponder()
        } else if branchNameTextField.isFirstResponder {
            branchNameTextField.text = pickerTitles[row]
            branchNameTextField.resignFirstResponder()
        }
        pickerView.endEditing(true)
    }
    
}

extension FilterCustomViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchLocation = touch.location(in: view)
        
        if !alertView.frame.contains(touchLocation) {
            return true
        }
        return false
    }
}
