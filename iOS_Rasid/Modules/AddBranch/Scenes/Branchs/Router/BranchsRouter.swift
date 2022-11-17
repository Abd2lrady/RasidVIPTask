//
//  Router.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import UIKit

protocol BranchsRouterProtocol {
    func routeToBranchDetails(facilityId: Int,
                              branchId: Int)
    func routeToAddBranch(facilityID: Int?)
    func routeToFilter()

    
}

class BranchsRouter {
    
    weak var view: BranchsViewController?
    var dataStore: BranchsDataStore
    
    init(view: BranchsViewController,
         dataStore: BranchsDataStore) {
        self.view = view
        self.dataStore = dataStore
    }
        
}

extension BranchsRouter: BranchsRouterProtocol {
    func routeToFilter() {
        let alert = UIAlertController()
        
        
    }
    
        func routeToAddBranch(facilityID: Int?) {
            guard let id = facilityID
            else { fatalError("facility ID not founded") }

            guard let service = (view?.interactor as? BranchsInteractor)?.service
            else { fatalError("wrong service") }

            let view = AddBranchConfigrator.configurate(service: service,
                                                        facilityId: id)
            navToAddBranch(destination: view)
        }
    
    func routeToBranchDetails(facilityId: Int,
                              branchId: Int) {
        guard let service = (view?.interactor as? BranchsInteractor)?.service
        else { fatalError("wrong service") }
        let view = BranchDetailsConfigrator.configrate(service: service,
                                                       facilityId: facilityId,
                                                       branchId: branchId)
        navToBranchDetails(destination: view)
        
    }
    
    private func navToBranchDetails(destination: UIViewController) {
        view?.navigationController?.pushViewController(destination,
                                                       animated: true)
    }
    
    private func navToAddBranch(destination: UIViewController) {
        view?.navigationController?.pushViewController(destination, animated: true)
    }

}
