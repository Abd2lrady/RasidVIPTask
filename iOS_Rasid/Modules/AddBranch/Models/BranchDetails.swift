//
//  BranchDetails.swift
//  iOS_Rasid
//
//  Created by Fintech on 08/11/2022.
//

import Foundation

enum BranchDetails {
    enum Request {
        case getDetails
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
//        init(model: BranchDetailsEntity) {
//            self.name = model.name
//            self.managerName = model.manager ?? ""
//            self.phoneNumber = model.phone
//            self.sellersCount = "\(model.sellersCount ?? 0)" 
//            self.regoin = model.region.name
//            self.city = model.city.name
//            self.district = model.district.name
//            self.street = model.address
//        }
    }
}
