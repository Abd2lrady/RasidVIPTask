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
    }
    
    struct Response {
        let branchs: [BranchEntity]
    }
    
    struct ViewModel {}
}
