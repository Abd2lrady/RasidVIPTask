//
//  AddBranchViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 09/11/2022.
//

import UIKit

class AddBranchViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addBranchButton: UIButton!
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var dataTextField: [UITextField]!
    let pickerView = UIPickerView()
    let pickerDelegate = PickerViewDelegate(titles: [])
    
    var interactor: AddBranchInteractorProtocol?
    
    private var pickerField: Fields?
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = pickerDelegate
        pickerView.dataSource = pickerDelegate
        pickerDelegate.selectedTitle = { selected in
            switch self.pickerField {
            case .city:
                self.dataTextField[Fields.city.rawValue].text = selected
                self.dataTextField[Fields.city.rawValue].resignFirstResponder()
            case .branchManger:
                self.dataTextField[Fields.branchManger.rawValue].text = selected
                self.dataTextField[Fields.branchManger.rawValue].resignFirstResponder()
            case .distrect:
                self.dataTextField[Fields.distrect.rawValue].text = selected
                self.dataTextField[Fields.distrect.rawValue].resignFirstResponder()
            default:
                print("error field selected")
        }
        
    }
        configUI()
}
    
    @IBAction func selectManagerButtonTapped(_ sender: Any) {
        pickerField = .branchManger
        dataTextField[Fields.branchManger.rawValue].becomeFirstResponder()
        pickerDelegate.titles = pickerDelegate.managers
        pickerView.reloadAllComponents()
        print("select manager button tapped")

    }
    
    @IBAction func selectDistrectButtonTapped(_ sender: Any) {
        pickerField = .distrect
        dataTextField[Fields.distrect.rawValue].becomeFirstResponder()
        pickerDelegate.titles = pickerDelegate.distrect
        pickerView.reloadAllComponents()

        print("select distect button tapped")

    }
    
    @IBAction func selectCityButtonTapped(_ sender: Any) {
        pickerField = .city
        dataTextField[Fields.city.rawValue].becomeFirstResponder()
        pickerDelegate.titles = pickerDelegate.cities
        pickerView.reloadAllComponents()

        print("select cites button tapped")
    }
}

extension AddBranchViewController {
    
    private func configUI() {
        configTitleLabel()
        configAddBranchButton()
        configTitleLabelsAndTextFieldPlaceholderStrings()
        
        titleLabels.forEach { label in
            label.font = Fonts.Cairo.regular.font(size: 16)
            label.textColor = Colors.addBranchTitleLabels.color
        }
        
        dataTextField.forEach { textField in
            textField.font = Fonts.Cairo.regular.font(size: 16)
            textField.textColor = Colors.addBranchTitleTextFields.color
            textField.backgroundColor = Colors.addBrnachTextFieldsBG.color
            textField.layer.cornerRadius = 7
            textField.borderStyle = .none
        }
        
    }
    
    private func configAddBranchButton() {
        let addBranchButtonTitleString = Strings.AddBranch.title
        let addBranchButtonTitleAtrributes: [NSAttributedString.Key: Any] =
        [.font: Fonts.Cairo.regular.font(size: 16),
         .foregroundColor: Colors.addBranchTitleLabel.color.cgColor]
        
        let addBranchButtonAttributedTitle = NSAttributedString(string: addBranchButtonTitleString,
                                                                attributes: addBranchButtonTitleAtrributes)
        addBranchButton.setAttributedTitle(addBranchButtonAttributedTitle,
                                           for: .normal)
        addBranchButton.backgroundColor = Colors.addBranchAddBranchButtonBG.color
        addBranchButton.layer.cornerRadius = 7
        addBranchButton.addTarget(self,
                                  action: #selector(addBranchButtonTapped),
                                  for: .touchUpInside)
        
    }
    
    private func configTitleLabel() {
        titleLabel.text = Strings.AddBranch.title
        titleLabel.font = Fonts.Cairo.regular.font(size: 16)
        titleLabel.textColor = Colors.addBranchTitleLabel.color
    }
    
    private func configTitleLabelsAndTextFieldPlaceholderStrings() {
        titleLabels[Fields.branchName.rawValue].text = Strings.AddBranch.branchNameTitle
        titleLabels[Fields.branchManger.rawValue].text = Strings.AddBranch.branchManagerTitle
        titleLabels[Fields.phoneNumber.rawValue].text = Strings.AddBranch.phoneTitle
        titleLabels[Fields.sellerCount.rawValue].text = Strings.AddBranch.sellersCountTitle
        titleLabels[Fields.distrect.rawValue].text = Strings.AddBranch.distrectTitle
        titleLabels[Fields.city.rawValue].text = Strings.AddBranch.cityTitle
        titleLabels[Fields.noughborhood.rawValue].text = Strings.AddBranch.nouborhoodTitle
        titleLabels[Fields.street.rawValue].text = Strings.AddBranch.streetTitle
        
        dataTextField[Fields.branchName.rawValue].placeholder = Strings.AddBranch.namePlaceholder
        dataTextField[Fields.branchManger.rawValue].placeholder = Strings.AddBranch.managerPlaceholder
        dataTextField[Fields.phoneNumber.rawValue].placeholder = Strings.AddBranch.phonePlaceholder
        dataTextField[Fields.sellerCount.rawValue].placeholder = Strings.AddBranch.sellersCountPlaceholder
        dataTextField[Fields.distrect.rawValue].placeholder = Strings.AddBranch.distrectPlaceholder
        dataTextField[Fields.city.rawValue].placeholder = Strings.AddBranch.cityPlaceholder
        dataTextField[Fields.noughborhood.rawValue].placeholder = Strings.AddBranch.nouborhoodPlaceholder
        dataTextField[Fields.street.rawValue].placeholder = Strings.AddBranch.streetPlaceholder
        
        dataTextField[Fields.branchManger.rawValue].inputView = pickerView
        dataTextField[Fields.city.rawValue].inputView = pickerView
        dataTextField[Fields.distrect.rawValue].inputView = pickerView
    }
    
    @objc
    func addBranchButtonTapped() {
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
