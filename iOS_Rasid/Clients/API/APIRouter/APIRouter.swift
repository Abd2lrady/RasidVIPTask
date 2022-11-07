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
}

extension APIRouter: APIRouterProtocol {

    var scheme: NetworkRequestScheme {
        switch self {
        case .getBranchs, .getBranchDetails:
            return .HTTPS
        }
    }
    
    var baseURL: String {
        switch self {
        case .getBranchs, .getBranchDetails:
            return Constants.API.Branches.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getBranchs(let facilityId, _):
            return "/api/vendor/facility/\(facilityId)/branches"
        case .getBranchDetails(let facilityId, let branchId):
            return "/api/vendor/facility/\(facilityId)/branches/\(branchId)"
        }
    }
    
    var method: NetworkRequestMethod {
        switch self {
        case .getBranchs, .getBranchDetails:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getBranchs(_, let page):
            return ["page": page]
        case .getBranchDetails:
            return [:]
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getBranchs, .getBranchDetails:
            return ["Authorization": "Bearer 2095|73eIgZ4TvOdyE3iELaidlZtHuh2x7z0J9znm9dJL"]
        }
    }

}
