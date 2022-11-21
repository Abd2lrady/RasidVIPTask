//
//  FilterCustomViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 21/11/2022.
//

import UIKit

class FilterCustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     }

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var branchNameTextField: UITextField!
    @IBOutlet weak var branchManagerTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    
    @IBOutlet var textFieldContainerViews: [UIView]!
    
    var buttonTappedCallback: ((Branch.Filter) -> Void)?
    let pickerView = UIPickerView()
    let datePickerView = UIDatePicker()
    let pickerDelegate = PickerViewDelegate(titles: [])

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
    }
    
    @IBAction func tapGestureDetected(_ sender: Any) {
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
        
        pickerDelegate.selectedTitle = { selected in
            
            if self.branchNameTextField.isFirstResponder {
                
                self.branchNameTextField.text = selected
                self.branchNameTextField.resignFirstResponder()
            } else if self.branchManagerTextField.isFirstResponder {
                
                self.branchManagerTextField.text = selected
                self.branchManagerTextField.resignFirstResponder()
            }
        }
        
        configDatePickerView()
        configManagerAndBranchPickerView()
    }
    
    private func configSearchButton() {
        
        searchButton.layer.cornerRadius = 7
        searchButton.addTarget(self,
                               action: #selector(searchButtonAction),
                               for: .touchUpInside)
        
    }
    
    private func configManagerAndBranchPickerView() {
        
        pickerView.delegate = pickerDelegate
        
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
        //        dataTextFields[Fields.branchName.rawValue].inputView = pickerView
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
            
            pickerDelegate.titles = ["cairo", "alex"]
            pickerView.reloadAllComponents()
            
        } else if branchManagerTextField.isFirstResponder {
            
            pickerDelegate.titles = pickerDelegate.managers
            pickerView.reloadAllComponents()
        }

    }
}
