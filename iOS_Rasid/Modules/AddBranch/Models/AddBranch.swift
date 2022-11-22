//
//  AddBranch.swift
//  iOS_Rasid
//
//  Created by Fintech on 10/11/2022.
//

import Foundation
// swiftlint: disable all
enum AddBranch {
    enum Request {
        case addBranch(details: RequestBody)
    }
    
    enum Response {
    case dismissView
    }
    
    struct ViewModel {
        let name: String
        let manager: String
        let phoneNumber: String
        let sellersCount: String
        let distrect: String
        let city: String
        let street: String
        let neihbourhood: String
    }
    
    struct RequestBody: Codable {
        let name: String?
        let manager: String?
        let phoneNumber: String?
        let sellersCount: String?
        let distrect: String?
        let city: String?
        let street: String?
        let neihbourhood: String?
        let lat: Double?
        let lng: Double?
        var address_id = 2
        var facility_id = 53

        func getBody() -> [String: Any] {
            let body: [String: Any] = ["ar": ["name": name] ,
                                        "manager": manager ?? "",
                                        "phone": phoneNumber ?? "",
                                        "salers_count": sellersCount ?? "",
                                        "distrect": distrect ?? "",
                                        "city": city ?? "",
                                        "street": street ?? "",
                                        "lat": lat ?? 0,
                                        "lng": lng ?? 0,
                                        "neihbourhood": neihbourhood ?? "",
                                       "address_id": 2,
                                       "facility_id": 53]
            return body
        }
    }
}
