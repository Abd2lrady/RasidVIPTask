//
//  BranchsService.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import Foundation
class BranchsService {
    let remoteBranchRepository: BranchsGateway
    init(remoteBranchRepository: BranchsGateway = RemoteBranchsRepository()) {
        self.remoteBranchRepository = remoteBranchRepository
    }
}

extension BranchsService: BranchsGateway {
    func getBranchs(for facilityId: Int, completionHandler: @escaping (Result<[BranchEntity], Error>) -> Void) {
        remoteBranchRepository.getBranchs(for: facilityId) { result in
            switch result {
            case .success(let branchs):
                completionHandler(.success(branchs))
                print(branchs)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBranchDetails(for branchId: Int,
                          completionHandler: @escaping (Result<[BranchDetailsEntity], Error>) -> Void) {
         
    }
    
}
