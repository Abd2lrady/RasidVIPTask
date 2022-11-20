//
//  Branch.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import Foundation

enum Branch {
    enum Request {
        case loadBranchs
        case loadMoreBranchs
        case filterBranchs(filters: Filter)
    }
    
    struct Response {
        let branchs: [BranchEntity]
    }
    
    struct ViewModel {
        let branchName: String
        let managerName: String
        let sellersCount: String
    }
    
    struct Filter {
        let branchName: String
        let managerName: String
        let from: String
        let to: String
        
        func getFilters() -> [String] {
            return [branchName, managerName, from, to].filter { !$0.isEmpty }
        }
        
        func getBody() -> [String: Any] {
            let body: [String: Any] = ["filter": [
                                        "manager.first_name": managerName,
                                        "translations.name": branchName,
                                        "vendor_branches.created_to": to,
                                        "vendor_branches.created_from": from
                                        ]
                                    ]
            return body
        }
    }
}
