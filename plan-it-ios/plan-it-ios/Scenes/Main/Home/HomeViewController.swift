//
//  HomeViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit
import FirebaseAuth
import Hero

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        try! Auth.auth().signOut()
        let vc = RootViewController.storyboardController()
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .fade
        self.hero.replaceViewController(with: vc)
    }
}
