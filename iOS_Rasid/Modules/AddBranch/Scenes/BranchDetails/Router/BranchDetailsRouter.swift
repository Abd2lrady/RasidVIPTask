//
//  BranchDetailsRouter.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import Foundation

class BranchDetailsRouter {
    
    weak var view: BranchDetailsViewControllerProtocol?
    var dataStore: BranchDetailsDataStore
    
    init(view: BranchDetailsViewControllerProtocol?,
         dataStore: BranchDetailsDataStore) {
        self.view = view
        self.dataStore = dataStore
    }
}
