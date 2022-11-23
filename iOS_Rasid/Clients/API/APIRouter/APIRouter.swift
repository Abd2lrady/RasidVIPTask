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
    case filterBranchs(facilityId: Int, filters: [String: Any])
}

extension APIRouter: APIRouterProtocol {

    var scheme: NetworkRequestScheme {
        switch self {
        case .getBranchs, .getBranchDetails, .addBranch, .filterBranchs:
            return .HTTPS
        }
    }
    
    var baseURL: String {
        switch self {
        case .getBranchs, .getBranchDetails, .addBranch, .filterBranchs:
            return Constants.API.Branches.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getBranchs(let facilityId, _), .addBranch(let facilityId, _), .filterBranchs(let facilityId, _):
            return "/api/vendor/facility/\(facilityId)/branches"
        case .getBranchDetails(let facilityId, let branchId):
            return "/api/vendor/facility/\(facilityId)/branches/\(branchId)"
        }
    }
    
    var method: NetworkRequestMethod {
        switch self {
        case .getBranchs, .getBranchDetails, .filterBranchs:
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
        case .addBranch(_, let param), .filterBranchs(_, let param):
            return param
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getBranchs, .getBranchDetails, .addBranch, .filterBranchs:
            return ["Authorization": "Bearer 960|s03iYTuZrvVOSOIjurEvHNbDiAFy4ONcCIq5fpOW",
                    "Accept": "Application/json"]
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .getBranchDetails, .getBranchs, .addBranch, .filterBranchs:
            return nil
        }
    }

}
