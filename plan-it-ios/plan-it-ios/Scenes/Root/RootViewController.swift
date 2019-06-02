//
//  RootViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit
import Hero

class RootViewController: UIViewController {

    @IBOutlet private var viewHandler: RootViewHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
//        let vc = SignUpViewController.storyboardController()
//        vc.hero.isEnabled = true
//        vc.hero.modalAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .pageOut(direction: .right))
//        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func singUpButtonPressed(_ sender: UIButton) {
        let vc = SignUpViewController.storyboardController()
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .pageOut(direction: .right))
        self.present(vc, animated: true, completion: nil)
    }
}
