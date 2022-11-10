//
//  AddBranchPresenter.swift
//  iOS_Rasid
//
//  Created by Fintech on 10/11/2022.
//

import Foundation

protocol AddBranchPresenterProtocol {
    
}

class AddBranchPresenter {
    weak var view: AddBranchViewControllerProtocol?
    
    init(view: AddBranchViewControllerProtocol) {
        self.view = view
    }
    
}

extension AddBranchPresenter: AddBranchPresenterProtocol {
    
}
