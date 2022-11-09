//
//  BranchsInteractor.swift
//  iOS_Rasid
//
//  Created by Fintech on 07/11/2022.
//

import Foundation

protocol BranchsInteractorProtocol {
    func getBranchs(request: Branch.Request)
}

protocol BranchsDataStore {
    var branchs: [BranchEntity]? { get set }
    var facilityId: Int { get set }
}

class BranchsInteractor {
    let presenter: BranchsPresenterProtocol
    let service: BranchsGateway
    var branchs: [BranchEntity]? = [BranchEntity]()
    var facilityId: Int
    var currentPage: Int = 1
    var totalPages: Int?

    init(presenter: BranchsPresenterProtocol,
         service: BranchsGateway,
         facilityId: Int) {
        self.presenter = presenter
        self.service = service
        self.facilityId = facilityId
    }
}

extension BranchsInteractor: BranchsInteractorProtocol, BranchsDataStore {
    func getBranchs(request: Branch.Request) {
        switch request {
        case .loadBranchs:
            getBranchs(facilityId: self.facilityId)
        case .loadMoreBranchs:
            self.currentPage += 1
//            guard currentPage <= totalPages ?? 1
//            else {
//                print("no more pages")
//                return
//            }
            loadMoreBranchs(facilityId: self.facilityId,
                            page: self.currentPage)
//            print("current page \(currentPage) from \(totalPages)")

        }
    }
    
    private func getBranchs(facilityId: Int) {
        service.getBranchs(for: facilityId, page: 1) { [weak self] result in
            switch result {
            case .success(let branchs):
                self?.branchs = branchs
                self?.presenter.presentBranchs(branchs: Branch.Response(branchs: branchs))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadMoreBranchs(facilityId: Int, page: Int) {
        service.getBranchs(for: facilityId, page: page) { [weak self] result in
            switch result {
            case .success(let branchs):
                self?.branchs = branchs
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}
