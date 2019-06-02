//
//  ViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/1/19.
//

import UIKit
import Hero

class SignUpViewController: UIViewController {
    
    static func storyboardController() -> SignUpViewController {
        let storyboard = UIStoryboard(name: "SignUpViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! SignUpViewController
        return vc
    }
    
    @IBOutlet private var viewHandler: SignUpViewHandler!
    private let interactor = SignUpInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler.setupTextField()
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}

