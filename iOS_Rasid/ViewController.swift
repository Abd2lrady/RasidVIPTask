//
//  ViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        getFacilites()
    }

    func getFacilites() {
        let facilityID = 2179
        
        APIClient.shared.request(for: .getBranchs(facilityId: facilityID)) { result in
            switch result {
            case .success(let data):
                let branchs = try? JSONDecoder().decode(ServerResponse<[BranchEntity]>.self, from: data)
                print(branchs)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}
