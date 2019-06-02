//
//  RootViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit
import Hero

class RootViewController: UIViewController {
    static func storyboardController() -> RootViewController {
        let storyboard = UIStoryboard(name: "RootViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! RootViewController
        return vc
    }
    
    @IBOutlet private var viewHandler: RootViewHandler!
    private let interactor = RootInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    private func initialSetup() {
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.viewHandler.loginButton.hero.id = "auth.title.label"
        let vc = SignUpViewController.storyboardController(.login)
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .zoomOut)
        self.present(vc, animated: true)
        
    }
    
    @IBAction func singUpButtonPressed(_ sender: UIButton) {
        self.viewHandler.signUpButton.hero.id = "auth.title.label"
        let vc = SignUpViewController.storyboardController(.signUp)
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .zoomOut)
        self.present(vc, animated: true)
    }
}
