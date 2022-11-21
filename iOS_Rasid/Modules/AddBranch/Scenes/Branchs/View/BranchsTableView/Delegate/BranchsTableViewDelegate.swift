//
//  BranchsTableViewDelegate.swift
//  iOS_Rasid
//
//  Created by Fintech on 07/11/2022.
//

import UIKit

class BranchsTableViewDelegate: NSObject {
    var loadMoreRequest: (() -> Void)?
    var showBranchDetails: ((Int?) -> Void)?
    var branchs: [Branch.ViewModel]
    
    init(branchs: [Branch.ViewModel]) {
        self.branchs = branchs
    }
}

extension BranchsTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         return UITableViewCell()
    }
    
    
}

extension BranchsTableViewDelegate: UITableViewDelegate {
    
}
