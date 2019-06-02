//
//  SettingsInteractor.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit
import FirebaseAuth

class SettingsInteractor: NSObject {
    public let cellID = "settingsCell"
    public var settingsTitles = ["Reset password",
                                 "Sing out"]
    
    public func logOut() {
        try! Auth.auth().signOut()
    }
}
