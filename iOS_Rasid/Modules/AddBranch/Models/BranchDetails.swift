//
//  BranchDetails.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import Foundation

enum BranchDetails {
    enum Request {
        case getDetails(facilityId: Int, branchId: Int)
    }

    struct Response {
        var details: BranchDetailsEntity
    }

    struct ViewModel {
        let name: String
        let managerName: String
        let phoneNumber: String
        let sellersCount: String
        let regoin: String
        let city: String
        let district: String
        let street: String
    }
}
