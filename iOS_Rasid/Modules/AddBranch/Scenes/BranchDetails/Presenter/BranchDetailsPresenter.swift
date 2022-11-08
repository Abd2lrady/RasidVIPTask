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
                                managerName: response.details.manager ?? "N/A",
                                phoneNumber: response.details.phone,
                                sellersCount: "\(response.details.sellersCount ?? 0)",
                                regoin: response.details.region.name,
                                city: response.details.city.name,
                                district: response.details.district.name,
                                street: response.details.address)
        
        view?.showBranchDetails(branchDetails: branchDetailsViewModel)
    }
    
}
