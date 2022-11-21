//
//  Router.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import UIKit

protocol BranchsRouterProtocol {
    func routeToBranchDetails(at index: Int)
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
    func routeToBranchDetails(at index: Int) {
        guard let branchId = dataStore.branchs?[index].id
        else { return }
        navToBranchDetails(facilityId: dataStore.facilityId,
                           branchId: branchId)
    }
    
    func routeToFilter() {
        let view = FilterCustomViewController()
        view.buttonTappedCallback = { [weak self] in
            self?.view?.filters = $0.getFilters()
            self?.view?.showFilters()
            self?.view?.filterBranchs(filters: $0)
        }
        navToFilter(destination: view)
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
    
    private func navToAddBranch(destination: UIViewController) {
        view?.navigationController?.pushViewController(destination, animated: true)
    }
    
    private func navToFilter(destination: UIViewController) {

        destination.modalPresentationStyle = .overFullScreen
        
        view?.present(destination, animated: true)
        
    }
    
    private func navToBranchDetails(facilityId: Int,
                                    branchId: Int) {
        
        guard let service = (view?.interactor as? BranchsInteractor)?.service
        else { fatalError("wrong service") }
        let destination = BranchDetailsConfigrator.configrate(service: service,
                                                              facilityId: facilityId,
                                                              branchId: branchId)
        view?.navigationController?.pushViewController(destination,
                                                       animated: true)
    }

}
