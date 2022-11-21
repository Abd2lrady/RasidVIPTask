//
//  BranchsInteractor.swift
//  iOS_Rasid
//
//  Created by Fintech on 07/11/2022.
//

import Foundation

protocol BranchsInteractorProtocol {
    func request(request: Branch.Request)
    func getBranchsCount() -> Int?
    func getBranch(at index: Int) -> BranchEntity?
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
    func getBranchsCount() -> Int? {
        branchs?.count
    }
    
    func getBranch(at index: Int) -> BranchEntity? {
        branchs?[index]
    }
    
    func request(request: Branch.Request) {
        switch request {
        case .loadBranchs:
            getBranchs(facilityId: self.facilityId)
        case .loadMoreBranchs:
            self.currentPage += 1
            guard currentPage <= totalPages ?? 1
            else {
                print("no more pages")
                return
            }
            loadMoreBranchs(facilityId: self.facilityId,
                            page: self.currentPage)
            
        case .filterBranchs(let filters):
            filterBranchs(facilityId: self.facilityId,
                          filters: filters)
            print(filters.getBody())
        }
    }
    
    private func getBranchs(facilityId: Int) {
        service.getBranchs(for: facilityId, page: 1) { [weak self] result in
            switch result {
            case .success(let response):
                guard let response = response else {return}

                self?.branchs = response.data
                self?.totalPages = response.meta?.lastPage
                self?.presenter.presentBranchs(branchs: Branch.Response(branchs: response.data ?? [BranchEntity]()))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadMoreBranchs(facilityId: Int, page: Int) {
        service.getBranchs(for: facilityId, page: page) { [weak self] result in
            
            guard let totalPages = self?.totalPages, page <= totalPages else { return }
            switch result {
            case .success(let response):
                guard let response = response else {return}
                self?.branchs?.append(contentsOf: response.data ?? [BranchEntity]())
                if let branchs = self?.branchs {
                    self?.presenter.presentBranchs(branchs: Branch.Response(branchs: branchs))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    private func filterBranchs(facilityId: Int,
                               filters: Branch.Filter) {
        service.filterBranchs(facilityID: facilityId,
                              filters: filters) { [weak self] result in
            
            switch result {
            case .success(let response):
                guard let response = response else {return}
                self?.branchs = response.data 
                if let branchs = self?.branchs {
                    self?.presenter.presentBranchs(branchs: Branch.Response(branchs: branchs))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
