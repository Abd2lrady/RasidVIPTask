//
//  AddBranchConfigrator.swift
//  iOS_Rasid
//
//  Created by Fintech on 10/11/2022.
//

import UIKit

class AddBranchConfigrator {
    
    static func configureconfigrate(service: BranchsGateway,
                                    facilityId: Int) -> UIViewController {
        let view = AddBranchViewController()
        let presenter = AddBranchPresenter(view: view)
        let interactor = AddBranchInteractor(presenter: presenter,
                                             service: service)
        view.interactor = interactor
        
        return view
    }
}
