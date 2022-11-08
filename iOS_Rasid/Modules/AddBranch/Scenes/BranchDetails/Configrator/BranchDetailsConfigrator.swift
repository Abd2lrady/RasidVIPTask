//
//  BranchDetailsConfigrator.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import UIKit

class BranchDetailsConfigrator {
    
    static func configrate(service: BranchsGateway,
                           facilityId: Int,
                           branchId: Int) -> UIViewController {
        let view = BranchDetailsViewController()
        let presenter = BranchDetailsPresenter(view: view)
        let interactor = BranchDetailsInteractor(presenter: presenter,
                                                 service: service,
                                                 facilityID: facilityId,
                                                 branchID: branchId)
        view.interactor = interactor
        
        return view
    }
}
