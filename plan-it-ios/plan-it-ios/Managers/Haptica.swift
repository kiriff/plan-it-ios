//
//  Haptica.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import Foundation
import Haptica

class PIHaptic {
    static func light() {
        Haptic.impact(.light).generate()
    }
    
    static func error() {
        Haptic.notification(.error).generate()
    }
    
    static func success() {
        Haptic.notification(.success).generate()
    }
}
