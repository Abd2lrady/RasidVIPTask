//
//  BranchsService.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import Foundation

class BranchsService {
    var page = 1
    let remoteBranchRepository: BranchsGateway
    init(remoteBranchRepository: BranchsGateway = RemoteBranchsRepository()) {
        self.remoteBranchRepository = remoteBranchRepository
    }
}

extension BranchsService: BranchsGateway {

    func getBranchs(for facilityId: Int,
                    page: Int,
                    completionHandler: @escaping (Result<[BranchEntity], Error>) -> Void) {

        remoteBranchRepository.getBranchs(for: facilityId, page: page) { result in
            switch result {
            case .success(let branchs):
                completionHandler(.success(branchs))
//                print(branchs)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
        
    func getMoreBranchs(for facilityId: Int, completionHandler: @escaping (Result<[BranchEntity], Error>) -> Void) {
        page += 1
        remoteBranchRepository.getBranchs(for: facilityId,
                                          page: page) { result in
            switch result {
            case .success(let branchs):
                completionHandler(.success(branchs))
//                print(branchs)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func getBranchDetails(facilityId: Int,
                          branchId: Int,
                          completionHandler: @escaping (Result<BranchDetailsEntity?, Error>) -> Void) {
        remoteBranchRepository.getBranchDetails(facilityId: facilityId,
                                                branchId: branchId) { result in
            switch result {
            case .success(let branchs):
                completionHandler(.success(branchs))
//                print(branchs)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func addBranch(facilityId: Int,
                   branchDetails: AddBranch.RequestBody,
                   completionHandler: @escaping (Result<Int?, Error>) -> Void) {
        
        remoteBranchRepository.addBranch(facilityId: facilityId,
                                         branchDetails: branchDetails) { result in
            completionHandler(.success(200))
            
        }
    }
}
