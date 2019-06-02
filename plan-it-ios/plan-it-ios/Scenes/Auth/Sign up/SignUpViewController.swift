//
//  ViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/1/19.
//

import UIKit
import Hero
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    static func storyboardController(_ state: AuthState) -> SignUpViewController {
        let storyboard = UIStoryboard(name: "SignUpViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! SignUpViewController
        vc.state = state
        vc.interactor.state = state
        return vc
    }
    
    @IBOutlet private var viewHandler: SignUpViewHandler!
    
    private let interactor = SignUpInteractor()
    
    private var state = AuthState.login
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        self.viewHandler.setupTextField()
        self.viewHandler.titleLabel.text = self.interactor.getTitle(forState: state)
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        HUD.show()
        PIHaptic.light()
        if let email = self.viewHandler.emailTextField.text, let password = self.viewHandler.passTextField.text {
            self.interactor.authorizeUser(email: email, password: password, successHandler: { [weak self] in
                guard let self = self else { return }
                HUD.hide()
                let vc = MainViewController.storyboardController()
                vc.hero.modalAnimationType = .fade
                self.heroReplaceViewController(with: vc)
            }) { [weak self] (error) in
                guard let self = self else { return }
                HUD.showError(error.localizedDescription)
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        PIHaptic.light()
        self.dismiss(animated: true, completion: nil)
    }
}

