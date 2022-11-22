//
//  BranchDetailsViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import UIKit

protocol BranchDetailsViewControllerProtocol: AnyObject {
    func showBranchDetails(branchDetails: (BranchDetails.ViewModel)?)
}

class BranchDetailsViewController: UIViewController {

    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var dataLabels: [UILabel]!
    @IBOutlet weak var editBranchButton: UIButton!
    
    var interactor: BranchDetailsInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        interactor?.getBranchDetails(request: BranchDetails.Request.getDetails)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        print("edit button tapped")
    }
    
}

extension BranchDetailsViewController {
    private func configUI() {
        editBranchButton.layer.cornerRadius = 7
        editBranchButton.layer.borderColor = Colors.branchDetailsDataLabels.color.cgColor
        editBranchButton.layer.borderWidth = 1
    }
}

extension BranchDetailsViewController: BranchDetailsViewControllerProtocol {
    func showBranchDetails(branchDetails: (BranchDetails.ViewModel)?) {
        dataLabels[0].text = branchDetails?.name
        dataLabels[1].text = branchDetails?.managerName
        dataLabels[2].text = branchDetails?.phoneNumber
        dataLabels[3].text = branchDetails?.sellersCount
        dataLabels[4].text = branchDetails?.district
        dataLabels[5].text = branchDetails?.city
        dataLabels[6].text = branchDetails?.regoin
        dataLabels[7].text = branchDetails?.street
    }
}
