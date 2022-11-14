//
//  BranchDetails.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import Foundation

struct BranchDetailsEntity: Codable {
    let id: Int
    let name: String
    let manager: String?
    let sellersCount: Int?
    let district, city, region: Location?
    let phone, lat, lng: String?
    let address: String?
    let email: String?
    let employeesCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, manager, email, address
        case phone, lat, lng, district, city, region
        case sellersCount = "salers_count"
        case employeesCount = "employees_count"
    }
}

// MARK: - City
struct Location: Codable {
    let id: Int
    let name: String
}
