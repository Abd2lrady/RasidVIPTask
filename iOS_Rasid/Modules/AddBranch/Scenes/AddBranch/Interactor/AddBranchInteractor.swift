//
//  AddBranchInteractor.swift
//  iOS_Rasid
//
//  Created by Fintech on 10/11/2022.
//

import Foundation

protocol AddBranchInteractorProtocol {
    
    func sendNewBranchDetailsBody(request: AddBranch.Request)
    
}

class AddBranchInteractor {
    var presenter: AddBranchPresenterProtocol
    var service: BranchsGateway
    
    init(presenter: AddBranchPresenterProtocol, service: BranchsGateway) {
        self.presenter = presenter
        self.service = service
    }
}

extension AddBranchInteractor: AddBranchInteractorProtocol {
    func sendNewBranchDetailsBody(request: AddBranch.Request) {
        print("interactor notified")
        switch request {
        case .addBranch(let body):
            print(body)
        }
    }

}
