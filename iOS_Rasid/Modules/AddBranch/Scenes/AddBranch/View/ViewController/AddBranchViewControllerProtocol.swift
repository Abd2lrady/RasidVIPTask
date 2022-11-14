//
//  AddBranchViewControllerProtocol.swift
//  iOS_Rasid
//
//  Created by Fintech on 10/11/2022.
//

import Foundation

protocol AddBranchViewControllerProtocol: AnyObject {
    func dismissView()
}

extension AddBranchViewController: AddBranchViewControllerProtocol {
    func dismissView() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
