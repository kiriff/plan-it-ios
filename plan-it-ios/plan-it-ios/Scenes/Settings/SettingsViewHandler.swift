//
//  SettingsViewHandler.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit
import FirebaseAuth

class SettingsViewHandler: NSObject {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    func setUserInfo() {
        if let user = Auth.auth().currentUser {
            emailTextField.text = user.email
            nickTextField.text = user.uid
        }
    }
}
