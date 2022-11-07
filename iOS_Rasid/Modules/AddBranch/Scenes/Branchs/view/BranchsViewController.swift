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
        // Do any additional setup after loading the view.
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
            print("load more branchs")

        }
    }
    
    func configUI() {
        branchsTableView.backgroundColor = .clear
        
        addBranchButton.setImage(Images.addBranchButtonIc.image,
                                 for: .normal)
        addBranchButton.addTarget(self,
                                  action: #selector(addBranchTapped),
                                  for: .touchUpInside)
        
        reportButton.layer.cornerRadius = 5
        reportButton.backgroundColor = Colors.branchsReportButtonBG.color
        let reportButtonTitleString = "اصدار تقرير"
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
        print("add Branch button tapped")
    }
}
