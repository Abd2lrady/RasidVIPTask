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
    
    lazy var branchTableViewDelegate = BranchsTableViewDelegate(branchs: [Branch.ViewModel(branchName: "السعودية",
                                                                                           managerName: "احمدعبدالراضى",
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
        // Do any additional setup after loading the view.
    }
    
}

extension BranchsViewController {
    func configBranchsTableView() {
        branchsTableView.backgroundColor = .clear
        let cellNib = UINib(nibName: "\(BranchCell.self)",
                            bundle: .main)
        branchsTableView.register(cellNib,
                                  forCellReuseIdentifier: BranchCell.reuseID)
        
        branchsTableView.dataSource = branchTableViewDelegate
    }
}
