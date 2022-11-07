//
//  RemoteBranchs.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import Foundation

class RemoteBranchsRepository {
    
    let client: APIClient
    let decoder: JSONDecoder
    var setTotalPages: ((Int?) -> Void)?
    
    init(client: APIClient = APIClient.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.client = client
        self.decoder = decoder
    }
    
}

extension RemoteBranchsRepository: BranchsGateway {
        
    func getBranchs(for facilityId: Int,
                    page: Int = 1,
                    completionHandler: @escaping (Result<[BranchEntity], Error>) -> Void) {
        client.request(for: .getBranchs(facilityId: facilityId, page: page)) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try self?.decoder.decode(ServerResponse<[BranchEntity]>.self,
                                                            from: data)
                    completionHandler(.success(response?.data ?? [BranchEntity]()))
                    self?.setTotalPages?(response?.meta.total)
                } catch {
                    completionHandler(.failure(error))
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBranchDetails(for branchId: Int,
                          completionHandler: @escaping (Result<[BranchDetailsEntity], Error>) -> Void) {
         
    }

}
