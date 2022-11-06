//
//  ViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import UIKit

class ViewController: UIViewController {
let repo = BranchsService()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        getFacilites()
    }

    func getFacilites() {
        let facilityID = 2179
        
        repo.getBranchs(for: facilityID) { result in
            switch result {
            case .success(let facilities):
                print(facilities)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
