//
//  BranchsPresenter.swift
//  iOS_Rasid
//
//  Created by Fintech on 07/11/2022.
//

import Foundation

protocol BranchsPresenterProtocol {
    func presentBranchs(branchs: Branch.Response)
}

class BranchsPresenter {
    weak var view: BranchsViewControllerProtocol?
    
    init(view: BranchsViewControllerProtocol) {
        self.view = view
    }
}

extension BranchsPresenter: BranchsPresenterProtocol {
    func presentBranchs(branchs: Branch.Response) {
        let branchsViewModels = branchs.branchs.map { branch in
            Branch.ViewModel(branchName: branch.name ?? "",
                             managerName: branch.manager ?? "",
                             sellersCount: "\(branch.salersCount ?? 0)")
        }
        print(branchsViewModels)
        view?.showBranchs(branchs: branchsViewModels)
    }
}
