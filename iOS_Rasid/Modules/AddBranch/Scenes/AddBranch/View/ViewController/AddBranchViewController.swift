//
//  AddBranchViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 09/11/2022.
//

import UIKit

protocol AddBranchViewControllerProtocol: AnyObject {
    func dismissView()
}

class AddBranchViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addBranchButton: UIButton!
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var dataTextField: [UITextField]!
    @IBOutlet var textFieldBGViews: [UIView]!
    
    var interactor: AddBranchInteractorProtocol?
    
    var pickerTitles = [String]()
    let cities = ["الاسكندرية", "القاهرة"]
    let distrect = ["المنطقة الاولى", "المنطقة الثانية"]
    let managers = ["احمد", "محمد"]
    
    let pickerView = UIPickerView()
    private var pickerField: Fields?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        configUI()
    }
    
    @IBAction func addBranchButtonTapped(_ sender: Any) {
        let name = dataTextField[Fields.branchName.rawValue].text
        let manager = dataTextField[Fields.branchManger.rawValue].text
        let phone = dataTextField[Fields.phoneNumber.rawValue].text
        let sellerCount = dataTextField[Fields.sellerCount.rawValue].text
        let distrect = dataTextField[Fields.distrect.rawValue].text
        let city = dataTextField[Fields.city.rawValue].text
        let noughborhood = dataTextField[Fields.noughborhood.rawValue].text
        let street = dataTextField[Fields.street.rawValue].text
        
        let body = AddBranch.RequestBody(name: name,
                                         manager: manager,
                                         phoneNumber: phone,
                                         sellersCount: sellerCount,
                                         distrect: distrect,
                                         city: city,
                                         street: street,
                                         neihbourhood: noughborhood,
                                         lat: 2,
                                         lng: 2)
        
        interactor?.sendNewBranchDetailsBody(request: .addBranch(details: body))
        print("add branch button tapped")
    }
    
}

extension AddBranchViewController {
    
    private func configUI() {
        configAddBranchButton()
        configTitleLabelsAndTextFieldPlaceholderStrings()
        
        dataTextField.forEach { textField in
            textField.layer.cornerRadius = 7
        }
        
        textFieldBGViews.forEach { view in
            view.layer.cornerRadius = 7
        }
    }
    
    private func configAddBranchButton() {
        addBranchButton.layer.cornerRadius = 7
        addBranchButton.addTarget(self,
                                  action: #selector(addBranchButtonTapped),
                                  for: .touchUpInside)
        
    }
    
    private func configTitleLabelsAndTextFieldPlaceholderStrings() {
        dataTextField[Fields.branchManger.rawValue].delegate = self
        dataTextField[Fields.city.rawValue].delegate = self
        dataTextField[Fields.distrect.rawValue].delegate = self
        
        dataTextField[Fields.branchManger.rawValue].inputView = pickerView
        dataTextField[Fields.city.rawValue].inputView = pickerView
        dataTextField[Fields.distrect.rawValue].inputView = pickerView
    }
    
    private enum Fields: Int {
        case branchName
        case branchManger
        case phoneNumber
        case sellerCount
        case distrect
        case city
        case noughborhood
        case street
    }
}

extension AddBranchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if dataTextField[Fields.city.rawValue].isFirstResponder {
            pickerField = .city
            pickerTitles = cities
            pickerView.reloadAllComponents()
        } else if dataTextField[Fields.distrect.rawValue].isFirstResponder {
            pickerField = .distrect
            pickerTitles = distrect
            pickerView.reloadAllComponents()
        } else if dataTextField[Fields.branchManger.rawValue].isFirstResponder {
            pickerField = .branchManger
            pickerTitles = managers
            pickerView.reloadAllComponents()
        }
    }
}

extension AddBranchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        if dataTextField[Fields.city.rawValue].isFirstResponder {
            self.dataTextField[Fields.city.rawValue].text = pickerTitles[row]
            self.dataTextField[Fields.city.rawValue].resignFirstResponder()
        } else if dataTextField[Fields.distrect.rawValue].isFirstResponder {
            self.dataTextField[Fields.distrect.rawValue].text = pickerTitles[row]
            self.dataTextField[Fields.distrect.rawValue].resignFirstResponder()
        } else if dataTextField[Fields.branchManger.rawValue].isFirstResponder {
            self.dataTextField[Fields.branchManger.rawValue].text = pickerTitles[row]
            self.dataTextField[Fields.branchManger.rawValue].resignFirstResponder()
        }
        pickerView.endEditing(true)
    }
    
}

extension AddBranchViewController: AddBranchViewControllerProtocol {
    func dismissView() {
        navigationController?.popViewController(animated: true)
    }
}
