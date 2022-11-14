//
//  APIRouter.swift
//  iOS_VIPTask
//
//  Created by Fintech on 17/10/2022.
//

import Foundation

enum APIRouter {
    
    case getBranchs(facilityId: Int, page: Int)
    case getBranchDetails(facilityId: Int, branchId: Int)
    case addBranch(facilityId: Int, branchDetails: [String: Any])
}

extension APIRouter: APIRouterProtocol {

    var scheme: NetworkRequestScheme {
        switch self {
        case .getBranchs, .getBranchDetails, .addBranch:
            return .HTTPS
        }
    }
    
    var baseURL: String {
        switch self {
        case .getBranchs, .getBranchDetails, .addBranch:
            return Constants.API.Branches.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getBranchs(let facilityId, _), .addBranch(let facilityId, _):
            return "/api/vendor/facility/\(facilityId)/branches"
        case .getBranchDetails(let facilityId, let branchId):
            return "/api/vendor/facility/\(facilityId)/branches/\(branchId)"
        }
    }
    
    var method: NetworkRequestMethod {
        switch self {
        case .getBranchs, .getBranchDetails:
            return .get
        case .addBranch:
            return .post
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getBranchs(_, let page):
            return ["page": page]
        case .getBranchDetails:
            return [:]
        case .addBranch(_, let param):
            return param
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getBranchs, .getBranchDetails, .addBranch:
            return ["Authorization": "Bearer 466|2E515UX4m9qdle4AlkW2gkIu4o6RQt5uKzYS6DB9",
                    "Accept": "Application/json"]
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .getBranchDetails, .getBranchs, .addBranch:
            return nil
        }
    }

}
