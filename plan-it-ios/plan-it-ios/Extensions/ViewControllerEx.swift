//
//  ViewControllerEx.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import Foundation
import UIKit
import SPStorkController

extension UIViewController {
    func storkPresent(_ vc: UIViewController, swipe: Bool, height: CGFloat?) {
        let delegate = SPStorkTransitioningDelegate()
        delegate.customHeight = height
        delegate.swipeToDismissEnabled = swipe
        vc.transitioningDelegate = delegate
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    var safeAreaHeight: CGFloat {
        let guide = self.view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        return height
    }
}

extension UIView {
    func rounded() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func makeShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 2, height: 6)
        self.layer.shadowRadius = 5
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
