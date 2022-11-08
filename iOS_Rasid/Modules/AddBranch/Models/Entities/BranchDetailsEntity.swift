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
    let district, city, region: Location
    let phone, lat, lng: String
    let address: String
    let email: String?
    let image: String?
    let employeesCount: Int?
    let transactionsCount: Int?
    let createdAt: String
    let isActive: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, manager, image, email, address
        case phone, lat, lng, district, city, region
        case sellersCount = "salers_count"
        case employeesCount = "employees_count"
        case transactionsCount = "transactions_count"
        case createdAt = "created_at"
        case isActive = "is_active"
    }
}

// MARK: - City
struct Location: Codable {
    let id: Int
    let name: String
}
