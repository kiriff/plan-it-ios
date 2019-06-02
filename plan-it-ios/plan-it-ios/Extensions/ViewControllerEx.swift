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
