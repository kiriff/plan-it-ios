//
//  SignUpInteractor.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpInteractor: NSObject {
    
    var state = AuthState.login
    
    func getTitle(forState state: AuthState) -> String {
        switch state {
        case .login:
            return "LOGIN"
        case .signUp:
            return "SING UP"
        }
    }
    
    func authorizeUser(email: String, password: String, successHandler: (() -> ())?, errorHandler: ((Error) -> ())?) {
        switch state {
        case .login:
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if user != nil && error == nil {
                    successHandler?()
                } else {
                    errorHandler?(error!)
                }
            }
        case .signUp:
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error == nil {
                    successHandler?()
                } else {
                    errorHandler?(error!)
                }
            }
        }
    }
}

