//
//  SettingsTableViewCell.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setup(_ text: String) {
        self.mainLabel.text = text
    }

}
