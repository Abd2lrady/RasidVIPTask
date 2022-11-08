//
//  BranchDetailsViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import UIKit

class BranchDetailsViewController: UIViewController {

    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var dataLabels: [UILabel]!
    @IBOutlet weak var editBranchButton: UIButton!
    
    var interactor: BranchDetailsInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }

}

extension BranchDetailsViewController {
    private func configUI() {
        
        titleLabels.forEach { label in
            label.font = Fonts.Cairo.regular.font(size: 16)
            label.textColor = Colors.branchDetailsTitleLabels.color
        }
        
        dataLabels.forEach { label in
            label.font = Fonts.Cairo.regular.font(size: 16)
            label.textColor = Colors.branchDetailsDataLabels.color
        }
                
        editBranchButton.layer.cornerRadius = 7
        editBranchButton.layer.borderColor = Colors.branchDetailsDataLabels.color.cgColor
        editBranchButton.layer.borderWidth = 1

        editBranchButton.backgroundColor = .clear
        let editBranchButtonTitleString = Strings.branchDetailsEditButtonTitle
        let editBranchButtonTitleAtrributes = [NSAttributedString.Key.font:
                                            Fonts.Cairo.regular.font(size: 16),
                                           NSAttributedString.Key.foregroundColor:
                                            Colors.branchDetailsDataLabels.color]
        let editBranchButtonAttributedTitle = NSAttributedString(string: editBranchButtonTitleString,
                                                                 attributes: editBranchButtonTitleAtrributes)
        editBranchButton.setAttributedTitle(editBranchButtonAttributedTitle,
                                            for: .normal)
        editBranchButton.addTarget(self,
                                   action: #selector(editBranchButtonTapped),
                                   for: .touchUpInside)    }
    
    @objc
    func editBranchButtonTapped() {
        print("edit button tapped")
    }
    
}
