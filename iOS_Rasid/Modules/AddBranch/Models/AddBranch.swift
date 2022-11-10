//
//  AddBranch.swift
//  iOS_Rasid
//
//  Created by Fintech on 10/11/2022.
//

import Foundation

enum AddBranch {
    enum Request {
        case addBranch(RequestBody)
    }
    
    struct Response { }
    
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
    
    struct RequestBody {
        let name: String?
        let manager: String?
        let phoneNumber: String?
        let sellersCount: String?
        let distrect: String?
        let city: String?
        let street: String?
        let neihbourhood: String?
        
        func getBody() -> [String: Any?] {
            let body: [String: Any?] = ["name": name,
                                        "manager": manager,
                                        "phone_number": phoneNumber,
                                        "seller_count": sellersCount,
                                        "distrect": distrect,
                                        "city": city,
                                        "street": street,
                                        "neihbourhood": neihbourhood]
            return body
        }
    }
}


