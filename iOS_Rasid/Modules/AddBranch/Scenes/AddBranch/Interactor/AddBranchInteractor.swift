//
//  AddBranchInteractor.swift
//  iOS_Rasid
//
//  Created by Fintech on 10/11/2022.
//

import Foundation
import Alamofire
// swiftlint: disable all
protocol AddBranchInteractorProtocol {
    
    func sendNewBranchDetailsBody(request: AddBranch.Request)
    
}

class AddBranchInteractor {
    var presenter: AddBranchPresenterProtocol
    var service: BranchsGateway
    var facilityId: Int
    init(presenter: AddBranchPresenterProtocol,
         service: BranchsGateway,
         facilityId: Int) {
        self.presenter = presenter
        self.service = service
        self.facilityId = facilityId
    }
}

extension AddBranchInteractor: AddBranchInteractorProtocol {
    func sendNewBranchDetailsBody(request: AddBranch.Request) {
        print("interactor notified")
        switch request {
        case .addBranch(let details):
            let param = details.getBody()
            debugPrint(param)
            service.addBranch(facilityId: facilityId,
                              branchDetails: details) { [weak self] result in
                
                switch result {
                case .success:
                    print("dismiss")
                    self?.presenter.present(response: .dismissView)
                case .failure:
                    print("show error alert")

                }
            }

            }
        }
    }
