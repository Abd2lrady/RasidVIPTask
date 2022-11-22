//
//  BranchDetailsPresenter.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import Foundation

protocol BranchDetailsPresenterProtocol {
    func presentBranchDetails(response: BranchDetails.Response)
}

class BranchDetailsPresenter {
    weak var view: BranchDetailsViewControllerProtocol?
    
    init(view: BranchDetailsViewControllerProtocol) {
        self.view = view
    }
}

extension BranchDetailsPresenter: BranchDetailsPresenterProtocol {
    func presentBranchDetails(response: BranchDetails.Response) {
        let branchDetailsViewModel =
        BranchDetails.ViewModel(name: response.details.name,
                                managerName: response.details.manager?.name ?? "N/A",
                                phoneNumber: response.details.phone ?? "N/A",
                                sellersCount: "\(response.details.sellersCount ?? 0)",
                                regoin: response.details.region?.name ?? "N/A",
                                city: response.details.city?.name ?? "N/A",
                                district: response.details.district?.name ?? "N/A",
                                street: response.details.address ?? "N/A")
        
        view?.showBranchDetails(branchDetails: branchDetailsViewModel)
    }
}
