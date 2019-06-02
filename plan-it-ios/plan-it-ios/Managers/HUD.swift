//
//  HUD.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import Foundation
import UIKit
import SVProgressHUD

class HUD {
    static func show() {
        SVProgressHUD.show()
    }
    
    static func hide() {
        SVProgressHUD.dismiss()
    }
    
    static func showSuccess(_ message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
    static func showError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
