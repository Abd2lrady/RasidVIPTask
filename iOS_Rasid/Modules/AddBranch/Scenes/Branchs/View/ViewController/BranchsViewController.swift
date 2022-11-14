//
//  BranchsViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import UIKit

class BranchsViewController: UIViewController {

    @IBOutlet weak var branchsTableView: UITableView!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var addBranchButton: UIButton!
    @IBOutlet weak var branchsTabelViewHeaderLabel: UILabel!
    var interactor: BranchsInteractorProtocol?
    var router: BranchsRouter?
    lazy var branchsTableViewDelegate = BranchsTableViewDelegate(branchs: [Branch.ViewModel(branchName: "السعودية",
                                                                                            managerName: "احمد",
                                                                                            sellersCount: "5"),
                                                                          Branch.ViewModel(branchName: "fintech",
                                                                                           managerName: "abdelrady",
                                                                                           sellersCount: "5"),
                                                                          Branch.ViewModel(branchName: "fintech",
                                                                                           managerName: "abdelrady",
                                                                                           sellersCount: "5")])
    override func viewDidLoad() {
        super.viewDidLoad()
        configBranchsTableView()
        configUI()
        interactor?.getBranchs(request: .loadBranchs)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getBranchs(request: .loadBranchs)
    }
}

extension BranchsViewController {
    func configBranchsTableView() {
        let cellNib = UINib(nibName: "\(BranchCell.self)",
                            bundle: .main)
        branchsTableView.register(cellNib,
                                  forCellReuseIdentifier: BranchCell.reuseID)
        
        branchsTableView.dataSource = branchsTableViewDelegate
        branchsTableView.delegate = branchsTableViewDelegate
        branchsTableViewDelegate.loadMoreRequest = {
            self.interactor?.getBranchs(request: .loadMoreBranchs)
            print("load more branchs")
        }
        branchsTableViewDelegate.showBranchDetails = { [weak self] indx in
            print("needs to show details for cell index \(indx)")
            // 1- get branch id from interactor
            let branchId = self?.router?.dataStore.branchs?[indx ?? 0].id
            // 2- navigate to details with id
            self?.router?.routeToBranchDetails(facilityId: self?.router?.dataStore.facilityId ?? 0,
                                               branchId: branchId ?? 0)
        }
    }
    
    func configUI() {
        branchsTableView.backgroundColor = .clear
        
        branchsTabelViewHeaderLabel.font = Fonts.Cairo.regular.font(size: 16)
        branchsTabelViewHeaderLabel.textColor = Colors.branchsBranchsListHeader.color
        branchsTabelViewHeaderLabel.text = Strings.branchListHeader

        addBranchButton.setImage(Images.addBranchButtonIc.image,
                                 for: .normal)
        addBranchButton.addTarget(self,
                                  action: #selector(addBranchTapped),
                                  for: .touchUpInside)
        
        reportButton.layer.cornerRadius = 5
        reportButton.backgroundColor = Colors.branchsReportButtonBG.color
        let reportButtonTitleString = Strings.reportButtonTitleString
        let reportButtonTitleAtrributes = [NSAttributedString.Key.font:
                                            Fonts.Cairo.regular.font(size: 16),
                                           NSAttributedString.Key.foregroundColor:
                                            Colors.branchsReportButtonTitle.color]
        let reportButtonAttributedTitle = NSAttributedString(string: reportButtonTitleString,
                                                             attributes: reportButtonTitleAtrributes)
        reportButton.setAttributedTitle(reportButtonAttributedTitle,
                                        for: .normal)
        reportButton.addTarget(self,
                               action: #selector(reportTapped),
                               for: .touchUpInside)
    }
    
    @objc
    func reportTapped() {
        print("report button tapped")
    }
    
    @objc
    func addBranchTapped() {
        router?.routeToAddBranch(facilityID: self.router?.dataStore.facilityId)
        print("add Branch button tapped")
    }
}
