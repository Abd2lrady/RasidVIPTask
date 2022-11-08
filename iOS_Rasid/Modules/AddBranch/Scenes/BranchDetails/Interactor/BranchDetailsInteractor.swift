//
//  BranchDetailsInteractor.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import Foundation

protocol BranchDetailsInteractorProtocol {
    func getBranchDetails(request: BranchDetails.Request)
}

protocol BranchDetailsDataStore {
    var details: BranchDetailsEntity? { get set }
    var facilityID: Int { get set }
    var branchId: Int { get set }
}

class BranchDetailsInteractor {
    var presenter: BranchDetailsPresenterProtocol
    var service: BranchsGateway
    var details: BranchDetailsEntity?
    var facilityID: Int
    var branchId: Int
    
    init(presenter: BranchDetailsPresenterProtocol,
         service: BranchsGateway,
         facilityID: Int,
         branchID: Int) {
        self.presenter = presenter
        self.service = service
        self.facilityID = facilityID
        self.branchId = branchID
    }
}

extension BranchDetailsInteractor: BranchDetailsInteractorProtocol,
                                   BranchDetailsDataStore {
    
    func getBranchDetails(request: BranchDetails.Request) {
        
        switch request {
        case .getDetails:
            getBranchDetails(facilityId: self.facilityID,
                             branchId: self.branchId)
        }
        
    }
    
    private func getBranchDetails(facilityId: Int,
                                  branchId: Int) {
        
        service.getBranchDetails(facilityId: facilityId,
                                 branchId: branchId) { [weak self] result in
            switch result {
            case .success(let response):
                self?.details = response
                guard let response = response
                else {return}
                self?.presenter.presentBranchDetails(response: BranchDetails.Response(details: response))
                self?.presenter.presentBranchDetails(response: BranchDetails.Response(details: response))
//                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
