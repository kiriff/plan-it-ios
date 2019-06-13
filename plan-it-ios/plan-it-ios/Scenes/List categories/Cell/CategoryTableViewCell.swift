//
//  CategoryTableViewCell.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/13/19.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkView.layer.cornerRadius = 5
        checkView.layer.borderWidth = 3
        checkView.layer.borderColor = UIColor.black.cgColor
    }

    public func setCategory(_ category: Category) {
        mainLabel.text = category.name
    }

}
