//
//  FilterCell.swift
//  iOS_Rasid
//
//  Created by Fintech on 20/11/2022.
//

import UIKit

class FilterCell: UICollectionViewCell {
    static let reuseID = "FilterCell"

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var filterLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backView.layer.cornerRadius = 7
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        filterLabel.text = ""
    }
    
}
