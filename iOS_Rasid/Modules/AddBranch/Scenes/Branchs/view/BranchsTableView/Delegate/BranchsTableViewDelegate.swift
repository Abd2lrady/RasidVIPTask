//
//  BranchsTableViewDelegate.swift
//  iOS_Rasid
//
//  Created by Fintech on 07/11/2022.
//

import UIKit

class BranchsTableViewDelegate: NSObject {
    var loadMoreRequest: (() -> Void)?
    var branchs: [Branch.ViewModel]
    
    init(branchs: [Branch.ViewModel]) {
        self.branchs = branchs
    }
}

extension BranchsTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BranchCell.reuseID,
                                                       for: indexPath) as? BranchCell
        else { fatalError("can`t dequeue branch cell") }
        cell.configCell(with: branchs[indexPath.row])
      return cell
    }
}

extension BranchsTableViewDelegate: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let dragOffestY = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let container = scrollView.frame.size.height
        
        if dragOffestY > ((totalContentHeight - container) + 100) {
            loadMoreRequest?()
        }

    }
    
}
