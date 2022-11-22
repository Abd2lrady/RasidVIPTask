//
//  BranchCell.swift
//  iOS_Rasid
//
//  Created by Fintech on 07/11/2022.
//

import UIKit

class BranchCell: UITableViewCell {
    static let reuseID = "BranchCell"
    
    var viewDetailsTapped: (() -> Void)?
    var cellIndex: Int?
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var managerNameLabel: UILabel!
    @IBOutlet weak var sellersCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    @IBAction func detailsButtonTapped(_ sender: Any) {
        
        viewDetailsTapped?()
    }
    
}

extension BranchCell {
    
    func configCell(with branch: Branch.ViewModel) {
        branchNameLabel.text = branch.branchName
        managerNameLabel.text = branch.managerName
        sellersCountLabel.text = branch.sellersCount
    }
}
