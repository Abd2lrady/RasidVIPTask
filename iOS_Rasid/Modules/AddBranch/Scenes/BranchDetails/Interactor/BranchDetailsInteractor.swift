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
    var branchID: Int { get set }
}

class BranchDetailsInteractor {
    var presenter: BranchDetailsPresenterProtocol
    var service: BranchsGateway
    var details: BranchDetailsEntity?
    var facilityID: Int
    var branchID: Int
    
    init(presenter: BranchDetailsPresenterProtocol,
         service: BranchsGateway,
         facilityID: Int,
         branchID: Int) {
        self.presenter = presenter
        self.service = service
        self.facilityID = facilityID
        self.branchID = branchID
    }
}

extension BranchDetailsInteractor: BranchDetailsInteractorProtocol,
                                   BranchDetailsDataStore {
    
    func getBranchDetails(request: BranchDetails.Request) {
        
        switch request {
        case .getDetails(let facilityID, let branchId):
            getBranchDetails(facilityId: facilityID, branchId: branchId)
        }
        
    }
    
    private func getBranchDetails(facilityId: Int,
                                  branchId: Int) {
        
        service.getBranchDetails(facilityId: facilityId,
                                 branchId: branchId) { [weak self] result in
            switch result {
            case .success(let response):
                self?.details = response
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
