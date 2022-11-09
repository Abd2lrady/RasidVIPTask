//
//  BranchsGateway.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import Foundation

protocol BranchsGateway {
    func getBranchs(for facilityId: Int,
                    page: Int,
                    completionHandler: @escaping (Result<[BranchEntity], Error>) -> Void)
    func getBranchDetails(facilityId: Int,
                          branchId: Int,
                          completionHandler: @escaping (Result<BranchDetailsEntity?, Error>) -> Void)
}
