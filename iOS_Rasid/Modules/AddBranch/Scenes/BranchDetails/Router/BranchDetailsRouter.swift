//
//  BranchDetailsRouter.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import UIKit

protocol BranchDetailsRouterProtocol {
}

class BranchDetailsRouter {
    
    weak var view: BranchDetailsViewController?
    var dataStore: BranchDetailsDataStore
    
    init(view: BranchDetailsViewController?,
         dataStore: BranchDetailsDataStore) {
        self.view = view
        self.dataStore = dataStore
    }
    
}

extension BranchDetailsRouter: BranchDetailsRouterProtocol {
}
