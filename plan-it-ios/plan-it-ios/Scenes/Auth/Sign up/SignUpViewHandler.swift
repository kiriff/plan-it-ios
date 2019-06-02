//
//  SignUpViewHandler.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit
import Hero

class SignUpViewHandler: NSObject {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    func setupTextField() {
        emailTextField.becomeFirstResponder()
    }
}
