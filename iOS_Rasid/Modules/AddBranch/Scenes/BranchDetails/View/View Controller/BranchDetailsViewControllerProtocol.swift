//
//  BranchDetailsProtocol.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import Foundation

protocol BranchDetailsViewControllerProtocol: AnyObject {
    func showBranchDetails(branchDetails: BranchDetails.ViewModel) 
}

extension BranchDetailsViewController: BranchDetailsViewControllerProtocol {
    func showBranchDetails(branchDetails: BranchDetails.ViewModel) {
        dataLabels[0].text = branchDetails.name
        dataLabels[1].text = branchDetails.managerName
        dataLabels[2].text = branchDetails.phoneNumber
        dataLabels[3].text = branchDetails.sellersCount
        dataLabels[4].text = branchDetails.district
        dataLabels[5].text = branchDetails.city
        dataLabels[7].text = branchDetails.regoin
        dataLabels[8].text = branchDetails.street
        
    }
    
}
