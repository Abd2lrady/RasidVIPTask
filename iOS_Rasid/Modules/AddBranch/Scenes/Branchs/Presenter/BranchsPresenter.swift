//
//  BranchsPresenter.swift
//  iOS_Rasid
//
//  Created by Fintech on 07/11/2022.
//

import Foundation

protocol BranchsPresenterProtocol {
    func presentBranchs(branchs: [Branch.ViewModel])
}

class BranchsPresenter {
    weak var view: BranchsViewControllerProtocol?
    
    init(view: BranchsViewControllerProtocol) {
        self.view = view
    }
}

extension BranchsPresenter: BranchsPresenterProtocol {
    func presentBranchs(branchs: [Branch.ViewModel]) {
        view?.showBranchs(branchs: branchs)
    }
}
