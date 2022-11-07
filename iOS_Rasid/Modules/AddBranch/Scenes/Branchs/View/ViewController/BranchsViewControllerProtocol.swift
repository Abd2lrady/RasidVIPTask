//
//  BranchsViewControllerProtocol.swift
//  iOS_Rasid
//
//  Created by Fintech on 07/11/2022.
//

import Foundation

protocol BranchsViewControllerProtocol: AnyObject {
    func showBranchs(branchs: [Branch.ViewModel])
}

extension BranchsViewController: BranchsViewControllerProtocol {
    func showBranchs(branchs: [Branch.ViewModel]) {
        branchsTableViewDelegate.branchs = branchs
        branchsTableView.reloadData()
    }
}
