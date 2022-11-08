//
//  Router.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import UIKit

protocol BranchsRouterProtocol {
    func routeToBranchDetails(branchId: Int)
        
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
    func routeToBranchDetails(branchId: Int) {

    }
    
    private func navToBranchDetails(destination: UIViewController) {
        
    }
}
