//
//  BranchEntity.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import Foundation

struct BranchEntity: Codable {
    let id: Int
    let name: String?
    let salersCount: Int?
    let manager: String?
    let image: String?
    let employeesCount: Int?
    let transactionsCount: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, manager, image
        case salersCount = "salers_count"
        case employeesCount = "employees_count"
        case transactionsCount = "transactions_count"
        case createdAt = "created_at"
    }
}

struct Meta: Codable {
    let total, from, to, count: Int
    let perPage, currentPage, lastPage: Int

    enum CodingKeys: String, CodingKey {
        case total, from, to, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case lastPage = "last_page"
    }
}
