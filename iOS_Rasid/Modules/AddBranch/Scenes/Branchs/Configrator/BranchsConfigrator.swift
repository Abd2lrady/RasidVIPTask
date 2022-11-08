//
//  BranchsConfigrator.swift
//  iOS_Rasid
//
//  Created by Fintech on 07/11/2022.
//

import UIKit

class BranchsConfigrator {
    static func configrate(facilityId: Int) -> UIViewController {
        let view = BranchsViewController()
        let presenter = BranchsPresenter(view: view)
        let service = BranchsService()
        let interactor = BranchsInteractor(presenter: presenter,
                                           service: service,
                                           facilityId: facilityId)
        let router = BranchsRouter(view: view,
                                   dataStore: interactor)
        view.router = router
        view.interactor = interactor
        return view
    }
}
