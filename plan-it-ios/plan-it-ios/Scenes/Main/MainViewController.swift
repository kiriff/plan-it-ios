//
//  MainViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit

class MainViewController: UITabBarController {

    static func storyboardController() -> MainViewController {
        let storyboard = UIStoryboard(name: "MainViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! MainViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
